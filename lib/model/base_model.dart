import 'dart:convert';

/**
 *网络请求的基类
 */
class BaseModel<T> {
  String code;
  String msg;
  T data;

  BaseModel({this.code, this.msg, this.data});

  static void jsonToModel(BaseModel baseModel, Map<String, dynamic> resultMap) {
    baseModel.code = resultMap["code"].toString();
    baseModel.msg = resultMap["message"];
  }

  static void jsonToList<T>(BaseModel<List<T>> baseModel,
      Map<String, dynamic> resultMap, Function operator) {
    baseModel.data = resultMap['data'] == null ? null : [];
    if (baseModel.data != null) {
      for (var dataItem in baseModel.data == null
          ? []
          : resultMap['data']['data']) {
        baseModel.data.add(
            operator(dataItem));
      }
    }
  }

  @override
  String toString() {
    return '{"errorCode": $code,"errorMsg": ${msg != null ? '${json
        .encode(msg)}' : 'null'},"data": $data}';
  }
}