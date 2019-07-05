import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mylove/config/application.dart';
import 'package:mylove/constant/common.dart';
import 'package:mylove/route/routes.dart';
import 'package:mylove/util/image_util.dart';
import 'package:mylove/util/sp_util.dart';

//加载页面
class LoadingPage extends StatefulWidget {
  @override
  _LoadingState createState() => new _LoadingState();
}

class _LoadingState extends State<LoadingPage> {

  @override
  void initState() {
    super.initState();
    //在加载页面停顿2秒
    new Future.delayed(Duration(seconds: 2), () {
      _getHasSkip();
    });
  }

  void _getHasSkip() async {
    bool keyGuide = SpUtil.getBool(
        Constant.has_skip_key_guide, defValue: false);
    if (!keyGuide) {
      Application.navigateTo(
          context: context, route: Routes.BOOT_PAGE, clearStack: true);
      return;
    }
    bool hasSkip = SpUtil.getBool(Constant.has_skip, defValue: false);
    if (!hasSkip) {
      Application.navigateTo(
          context: context, route: Routes.SPLASH_PAGE, clearStack: true);
    } else {
      Application.navigateTo(
          context: context, route: Routes.MAIN_PAGE, clearStack: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Stack(
        children: <Widget>[
          //加载页面居中背景图 使用cover模式
          Image.asset(ImageUtil.getImgPath("loading"), fit: BoxFit.cover,),
        ],
      ),
    );
  }
}