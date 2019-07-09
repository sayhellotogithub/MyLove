import 'package:mylove/model/article_model.dart';
import 'package:mylove/model/list_model.dart';
import 'package:mylove/mvp/i_presenter.dart';
import 'package:mylove/mvp/i_view.dart';

abstract class View extends IView {
  void getArticleListSuccess(ListModel<Article> articleModel);
}

abstract class Presenter extends IPresenter {
  void getArticleList(int page, int size);
}