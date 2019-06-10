import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:mylove/constant/common.dart';
import 'package:mylove/model/splash_model.dart';
import 'package:mylove/util/http_util.dart';
import 'package:mylove/util/image_util.dart';
import 'package:mylove/util/sp_helper.dart';
import 'package:mylove/util/timer_util.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  String title;

  SplashPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }

}

class SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil;
  SplashModel _splashModel;

  //引导页图片资源
  List<String> _guideList = [
    ImageUtil.getImgPath('icon_guide_1'),
    ImageUtil.getImgPath('icon_guide_2'),
    ImageUtil.getImgPath('icon_guide_3')
  ];

  @override
  void initState() {
    super.initState();
    _loadSplashData();
    _initAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(child: Image(
        image: AssetImage("assets/images/splash.png"), fit: BoxFit.fill,));
    },);
  }

  ///加载Splash页面数据
  ///
  void _loadSplashData() {
    _splashModel = SpHelper.getObject(Constant.key_splash_model);
    if (_splashModel != null) {
      setState(() {});
    }
    HttpUtil httpUtil = new HttpUtil();
    httpUtil.getSplash().then((model) {
      if (!ObjectUtil.isEmpty(model.imgUrl)) {
        if (_splashModel == null || (_splashModel.imgUrl != model.imgUrl)) {
          SpHelper.putObject(Constant.key_splash_model, model);
          setState(() {
            _splashModel = model;
          });
        }
      } else {
        SpHelper.putObject(Constant.key_splash_model, null);
      }
    });
  }

  Future _initAsync() async {
    await SpUtil.getInstance();
    _loadSplashData();
    Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
//      SpUtil.putBool(Constant.key_guide, false);
      if (SpUtil.getBool(Constant.key_guide, defValue: true) &&
          ObjectUtil.isNotEmpty(_guideList)) {
        SpUtil.putBool(Constant.key_guide, false);
        _initBanner();
      } else {
//    _initSplash();
      }
    });
  }

  void _initBanner() {
//    _initBannerData();
//    setState(() {
//      _status = 2;
//    });
  }
}


