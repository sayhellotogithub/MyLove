import 'package:mylove/mvp/i_lifecycle.dart';
import 'package:mylove/mvp/i_view.dart';

abstract class IPresenter<T extends IView> implements ILifecycle {
  void attachView(T view);

  void detachView();
}