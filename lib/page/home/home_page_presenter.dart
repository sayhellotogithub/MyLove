import 'package:mylove/http/api_service.dart';
import 'package:mylove/model/article_model.dart';
import 'package:mylove/model/list_model.dart';
import 'package:mylove/mvp/base_presenter.dart';
import 'package:mylove/page/home/home_page_contact.dart';

class HomePagePresenter extends BasePresenter<View> implements Presenter {
  @override
  void getArticleList(int page, int size) {
    ApiService().getArticleList(
        page, successCallBack: (ListModel<Article> _articleModel) {
      view.getArticleListSuccess(_articleModel);
    });
  }
}