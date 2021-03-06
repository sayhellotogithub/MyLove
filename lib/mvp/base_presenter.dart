import 'package:dio/dio.dart';
import 'package:mylove/http/dio_utils.dart';
import 'package:mylove/mvp/i_lifecycle.dart';
import 'package:mylove/mvp/i_lifecycle.dart';
import 'package:mylove/mvp/i_presenter.dart';
import 'package:mylove/mvp/i_view.dart';


class BasePresenter<V extends IView> extends IPresenter {

  V view;

  CancelToken _cancelToken;

  BasePresenter() {
    _cancelToken = CancelToken();
  }


  @override
  void dispose() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  void requestNetwork<T>(Method method, String url,
      {Function(T t) onSuccess, Function(List<
          T> list) onSuccessList, Function(int code, String mag) onError,
        Map<String, dynamic> params, Map<String, dynamic> queryParameters,
        CancelToken cancelToken, Options options, bool isList: false}) {
    view.showProgress();
    DioUtils.instance.requestNetwork<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
        onSuccess: (data) {
          view.closeProgress();
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onError: (code, msg) {
          view.closeProgress();
          if (msg.isNotEmpty) {
            view.showToast(msg);
          }
          if (onError != null) {
            onError(code, msg);
          }
        }
    );
  }

  @override
  void attachView(IView view) {
    this.view = view;
  }

  @override
  void detachView() {
    this.view = null;
  }

  @override
  void deactivate() {
  }

  @override
  void didChangeDependencies() {
  }

  @override
  void didUpdateWidgets<W>(W oldWidget) {
  }

  @override
  void initState() {
  }
}
