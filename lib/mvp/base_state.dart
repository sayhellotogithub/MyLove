import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylove/mvp/i_presenter.dart';
import 'package:mylove/mvp/i_view.dart';
import 'package:mylove/util/image_util.dart';
import 'package:mylove/util/toast.dart';

abstract class BaseState<T extends StatefulWidget, V extends IPresenter>
    extends State<T>
    implements IView {
  bool _isAppBarShow = true; //导航栏是否显示

  bool _isErrorWidgetShow = false; //错误信息是否显示
  String _errorContentMesage = "网络请求失败，请检查您的网络";
  String _errorImgName = "ic_error";
  String _emptyImgName = "ic_empty";

  bool _isLoadingWidgetShow = false;

  bool _isEmptyWidgetShow = false;
  String _emptyWidgetContent = "暂无数据~";

  FontWeight _fontWidget = FontWeight.w600; //错误页面和空页面的字体粗度

  V presenter;

  BaseState() {
    presenter = createPresenter();
    presenter?.attachView(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getBaseAppBar(),
        body: Container(
          color: Colors.white, //背景颜色，可自己变更
          child: Stack(
            children: <Widget>[
              getContentWidget(context),
              _getBaseErrorWidget(),
              _getBaseEmptyWidget(),
              _getBassLoadingWidget(),
            ],
          ),
        ));
  }

  Widget getContentWidget(BuildContext context);
  ///设置导航栏隐藏或者显示
  void setAppBarVisible(bool isVisible) {
    setState(() {
      _isAppBarShow = isVisible;
    });
  }

  ///暴露的错误页面方法，可以自己重写定制
  Widget getErrorWidget() {
    return Container(
      //错误页面中心可以自己调整
      padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
          Image(
          image: AssetImage(ImageUtil.getImgPath(_errorImgName)),
      width: 120,
      height: 120,
    )
    ,
    Container
    (
    margin
        :
    EdgeInsets
        .
    fromLTRB
    (
    0
    ,
    20, 0, 0),
    child: Text
    (_errorContentMesage,
    style: TextStyle(
    color: Colors
        .grey,
    fontWeight: _fontWidget,
    )),
    ),
    Container(
    margin: EdgeInsets.fromLTRB(
    0, 20, 0, 0),
    child
        : OutlineButton(
    child: Text("重新加载"
    ,
    style: TextStyle(
    color: Colors.grey
    ,
    fontWeight: _fontWidget,
    )),
    onPressed:
    () =>
    {
    onClickErrorWidget()
    }
    ,
    )
    )
    ]
    ,
    )
    ,
    )
    ,
    );
  }

  ///点击错误页面后展示内容
  void onClickErrorWidget();

  Widget getLoadingWidget() {
    return Center(
        child: CupertinoActivityIndicator(
          radius: 15.0, //值越大加载的图形越大
        ));
  }

  Widget getEmptyWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                color: Colors.black12,
                image: AssetImage(ImageUtil.getImgPath(_emptyImgName)),
                width: 150,
                height: 150,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(_emptyWidgetContent,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: _fontWidget,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _getBaseAppBar() {
    return PreferredSize(
        child: Offstage(
          offstage: !_isAppBarShow,
          child: getAppBar(),
        ),
        preferredSize: Size.fromHeight(50));
  }

  ///导航栏 appBar
  AppBar getAppBar();

  Widget _getBaseErrorWidget() {
    return Offstage(
      offstage: !_isErrorWidgetShow,
      child: getErrorWidget(),
    );
  }

  Widget _getBassLoadingWidget() {
    return Offstage(
      offstage: !_isLoadingWidgetShow,
      child: getLoadingWidget(),
    );
  }

  Widget _getBaseEmptyWidget() {
    return Offstage(
      offstage: !_isEmptyWidgetShow,
      child: getEmptyWidget(),
    );
  }

  V createPresenter();

  @override
  void closeProgress() {
    debugPrint('-----close-----');
  }

  @override
  void showProgress() {
    debugPrint('-----show-----');
  }

  @override
  void showToast(String string) {
    Toast.show(string);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    presenter.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    presenter.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    presenter.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgets<T>(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    presenter.initState();
  }

  void didUpdateWidgets<W>(W oldWidget) {
    presenter.didUpdateWidgets<W>(oldWidget);
  }
}