//mvp View


abstract class IView {
  ///显示Progress
  void showProgress();

  ///关闭Progress
  void closeProgress();

  ///展示Toast
  void showToast(String msg);
}
