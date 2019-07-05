/**
 *网络请求的基类
 */
class BaseModel<T> {
  int errorCode;
  String errorMsg;
  T data;
}