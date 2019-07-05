import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylove/config/application.dart';
import 'package:mylove/constant/color_constant.dart';
import 'package:mylove/constant/common.dart';
import 'package:mylove/model/splash_model.dart';
import 'package:mylove/route/routes.dart';
import 'package:mylove/util/image_util.dart';
import 'package:mylove/util/sp_util.dart';
import 'package:rxdart/rxdart.dart';

///
/// splash界面
///
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
  int _status = 0;
  int _count = 3;
  List<Widget> _bannerList = new List();

  //引导页图片资源
  List<String> _guideList = [
    ImageUtil.getImgPath('icon_guide_1'),
    ImageUtil.getImgPath('icon_guide_2'),
    ImageUtil.getImgPath('icon_guide_3')
  ];

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Widget _buildSplashBg() {
    return new Image.asset(
      ImageUtil.getImgPath('splash'),
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          ),
          new Offstage(
            offstage: !(_status == 2),
            child: ObjectUtil.isEmpty(_bannerList)
                ? new Container()
                : new Swiper(
                autoStart: false,
                circular: false,
                indicator: CircleSwiperIndicator(
                  radius: 4.0,
                  padding: EdgeInsets.only(bottom: 30.0),
                  itemColor: Colors.black26,
                ),
                children: _bannerList),
          ),
          new Offstage(
            offstage: !(_status == 1),
            child: new Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  _goMain();
                },
                child: new Container(
                    padding: EdgeInsets.all(12.0),
                    child: new Text(
                      '跳过 $_count',
                      style: new TextStyle(
                          fontSize: 14.0, color: Colors.white),
                    ),
                    decoration: new BoxDecoration(
                        color: Color(0x66000000),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: new Border.all(
                            width: 0.33, color: ColorConstant.divider))),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _initAsync() async {
    await SpUtil.getInstance();
    Observable.just(1).delay(new Duration(milliseconds: 1000)).listen((_) {
      if (SpUtil.getBool(Constant.key_guide, defValue: true) &&
          ObjectUtil.isNotEmpty(_guideList)) {
        SpUtil.putBool(Constant.key_guide, false);
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }

  void _initSplash() {
    _doCountDown();
  }

  void _doCountDown() {
    setState(() {
      _status = 1;
    });
    _timerUtil = new TimerUtil(mTotalTime: _count * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  void _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  /**
   * 初始化Banner数据
   */
  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(new Stack(
          children: <Widget>[
            new Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                margin: EdgeInsets.only(bottom: 160.0),
                child: new InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: "click");
                    _goMain();
                  },
                  child: new CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.indigoAccent,
                    child: new Padding(
                      padding: EdgeInsets.all(2.0),
                      child: new Text(
                        '立即体验',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
      } else {
        _bannerList.add(new Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }

  void _goMain() {
    Application.navigateTo(context: context, route: "${Routes.MAIN_PAGE}");
  }

  @override
  void dispose() {
    super.dispose();
    _timerUtil?.cancel();
  }
}


