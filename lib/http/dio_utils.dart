import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mylove/http/api.dart';
import 'package:mylove/http/error_handle.dart';
import 'package:mylove/http/intercept.dart';
import 'package:mylove/model/base_model.dart';
import 'package:mylove/util/log_utils.dart';
import 'package:mylove/util/toast.dart';
import 'package:rxdart/rxdart.dart';

/// @weilu https://github.com/simplezhli
class DioUtils {

  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleton;
  }

  static Dio _dio;

  Dio getDio() {
    return _dio;
  }

  DioUtils._internal(){
    var options = BaseOptions(
      connectTimeout: 15000,
      receiveTimeout: 15000,
      responseType: ResponseType.plain,
      validateStatus: (status) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      baseUrl: Api.BASE_HTTP,
//      contentType: ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8'),
    );
    _dio = Dio(options);
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    /// 统一添加身份验证请求头
    _dio.interceptors.add(AuthInterceptor());

    /// 刷新Token
    _dio.interceptors.add(TokenInterceptor());

    /// 打印Log
    _dio.interceptors.add(LoggingInterceptor());

    /// 适配数据
    _dio.interceptors.add(AdapterInterceptor());
  }

  // 数据返回格式统一，统一处理异常
  Future<Response> _request<T>(String method, String url,
      {Map<String, dynamic> data, Map<String,
          dynamic> queryParameters, CancelToken cancelToken, Options options}) async {
    var response = await _dio.request(url, data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    return response;
  }

  BaseModel parseError() {
    return BaseModel(
        code: ExceptionHandle.parse_error.toString(),
        msg: "数据解析错误",
        data: null);
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  /// 统一处理(onSuccess返回T对象，onSuccessList返回List<T>)
  requestNetwork<T>(Method method, String url,
      {Function onSuccess, Function(int code, String msg) onError,
        Future<Response> onSuccessRespond,
        Map<String, dynamic> params, Map<String,
          dynamic> queryParameters, CancelToken cancelToken, Options options}) {
    String m;
    switch (method) {
      case Method.get:
        m = "GET";
        break;
      case Method.post:
        m = "POST";
        break;
      case Method.put:
        m = "PUT";
        break;
      case Method.patch:
        m = "PATCH";
        break;
      case Method.delete:
        m = "DELETE";
        break;
    }
    Observable.fromFuture(
        onSuccessRespond = _request<T>(m, url, data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken))
        .asBroadcastStream()
        .listen((result) {
      //将数据转成Map
      onSuccess(json.decode(result.data.toString()));
    }, onError: (e) {
      if (CancelToken.isCancel(e)) {
        print("取消请求接口： $url");
      }
      Error error = ExceptionHandle.handleException(e);
      onError == null ? _onError(error.code, error.msg) : onError(
          error.code, error.msg);
    });
  }

  _onError(int code, String mag) {
    Log.e("接口请求异常： code: $code, mag: $mag");
    Toast.show(mag);
  }
}

enum Method {
  get,
  post,
  put,
  patch,
  delete,
}