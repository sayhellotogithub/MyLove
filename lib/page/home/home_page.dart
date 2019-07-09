import 'package:flutter/material.dart';
import 'package:mylove/componment/webview_page.dart';
import 'package:mylove/model/article_model.dart';
import 'package:mylove/model/list_model.dart';
import 'package:mylove/mvp/base_state.dart';
import 'package:mylove/mvp/base_widget.dart';
import 'package:mylove/page/home/banner.dart';
import 'package:mylove/page/home/home_page_contact.dart';
import 'package:mylove/page/home/home_page_presenter.dart';

class HomePage extends BaseWidget {
  @override
  BaseState getState() {
    return HomePageState();
  }
}

class HomePageState extends BaseState<HomePage, Presenter> implements View {
  List<Article> _datas = new List();

  ScrollController _scrollController = ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  int _page = 0;


  @override
  void initState() {
    super.initState();
    setAppBarVisible(false);

    getData();
    _scrollController.addListener(() {
      //滑到了底部，加载更多
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }

      //当前位置是否超过屏幕高度
      if (_scrollController.offset < 200 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 200 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  //获取文章列表数据
  Future<Null> getData() async {
    presenter.getArticleList(_page, 20);
  }

  //加载更多的数据
  Future<Null> _getMore() async {
    _page++;
    getData();
  }

  @override
  AppBar getAppBar() {
    return AppBar(
      title: Text("不显示"),
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        displacement: 15,
        onRefresh: getData,
        child: ListView.separated(
            itemBuilder: _renderRow,
            physics: new AlwaysScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 0.5,
                color: Colors.black26,
              );
            },
            controller: _scrollController,
            //包含轮播图和加载更多
            itemCount: _datas.length + 2),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            //返回到顶部时执行动画
            _scrollController.animateTo(.0,
                duration: Duration(milliseconds: 200), curve: Curves.ease);
          }),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        height: 200,
        color: Colors.green,
        child: new BannerWidget(),
      );
    }

    if (index < _datas.length - 1) {
      return new InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new WebViewPage(
                title: _datas[index - 1].title, url: _datas[index - 1].link);
          }));
        },
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: <Widget>[
                  Text(
                    _datas[index - 1].author,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Text(
                      _datas[index - 1].niceDate,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _datas[index - 1].title,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3D4E5F),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _datas[index - 1].superChapterName,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void onClickErrorWidget() {
    showProgress();
    getData();
  }


  @override
  Presenter createPresenter() {
    return new HomePagePresenter();
  }

  @override
  void getArticleListSuccess(ListModel<Article> articleModel) {
    //成功
    if (articleModel.datas.length > 0) {
      //有数据
      // showContent();
      setState(() {
        _datas.clear();
        _datas.addAll(articleModel.datas);
      });
    } else {
      //数据为空
      //showEmpty();
    }
  }

}