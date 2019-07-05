import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylove/constant/index_tab.dart';
import 'package:mylove/generated/i18n.dart';
import 'package:mylove/model/state_model/tab_state_model.dart';
import 'package:mylove/page/home/home_page.dart';
import 'package:scoped_model/scoped_model.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  static int lastExitTime = 0;
  TabBarStateModel tabBarStateModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    tabBarStateModel = TabBarStateModel();
  }

  /**
   * 自定义返回键事件
   * 一定时间内点击两次退出，反之提示
   */
  Future<bool> _onBackPressed() async {
    if (tabBarStateModel.tabBarCurrentIndex != 0) {
      tabBarStateModel.changeTabBarCurrentIndex(0);
      return await Future.value(false);
    }
    int nowExitTime = DateTime
        .now()
        .millisecondsSinceEpoch;
    if (nowExitTime - lastExitTime > 2000) {
      lastExitTime = nowExitTime;
      Fluttertoast.showToast(
          msg: S
              .of(context)
              .press_again_exit,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return await Future.value(false);
    }
    return await Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: ScopedModel<TabBarStateModel>(
        model: tabBarStateModel,
        child: ScopedModelDescendant<TabBarStateModel>(
          builder: (context, child, model) {
            return Scaffold(
              body: _renderTabContent(model),
              bottomNavigationBar: _renderBottomNavigationBar(model),
            );
          },
        ),
      ),
    );
  }

  /**
   * Tab对应视图
   */
  _renderTabContent(TabBarStateModel model) {
    return IndexedStack(
      index: model.tabBarCurrentIndex,
      children: <Widget>[
        HomePage(),
        Center(child: new Text("Hello")),
        Center(child: new Text("Pop")),
        Center(child: new Text("Mine")),
      ],
    );
  }

  /**
   * TabBar
   */
  _renderBottomNavigationBar(TabBarStateModel model) {
    return BottomNavigationBar(
      items: _renderTabBarItem(model.tabBarCurrentIndex),
      onTap: (index) => model.changeTabBarCurrentIndex(index),
      currentIndex: model.tabBarCurrentIndex,
      type: BottomNavigationBarType.fixed,
    );
  }

  /**
   * TabBarItem
   */
  List<BottomNavigationBarItem> _renderTabBarItem(int currentIndex) {
    return [
      BottomNavigationBarItem(icon: _getTabBarItemIcon(0, currentIndex),
          title: _getTabBarItemText(0, currentIndex)),
      BottomNavigationBarItem(icon: _getTabBarItemIcon(1, currentIndex),
          title: _getTabBarItemText(1, currentIndex)),
      BottomNavigationBarItem(icon: _getTabBarItemIcon(2, currentIndex),
          title: _getTabBarItemText(2, currentIndex)),
      BottomNavigationBarItem(icon: _getTabBarItemIcon(3, currentIndex),
          title: _getTabBarItemText(3, currentIndex)),
    ];
  }

  /**
   * TabBar图标
   */
  _getTabBarIcon(String path, Color color) {
    return Image.asset(path, width: 25.0, height: 25.0, color: color);
  }

  /**
   *  TabBar图标
   */
  Image _getTabBarItemIcon(index, currentIndex) {
    if (currentIndex == index) {
      return _getTabBarIcon(tabIcon[index][1], Theme
          .of(context)
          .primaryColor);
    }
    return _getTabBarIcon(tabIcon[index][0], null);
  }

  /**
   * TabBar文字
   */
  Text _getTabBarItemText(index, currentIndex) {
    return Text(
        tabTitle[index], style: TextStyle(color: index == currentIndex ? Theme
        .of(context)
        .primaryColor : Color.fromARGB(255, 192, 193, 195)));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
