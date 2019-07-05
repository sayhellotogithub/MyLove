import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:mylove/config/application.dart';
import 'package:mylove/constant/common.dart';
import 'package:mylove/route/routes.dart';
import 'package:mylove/util/image_util.dart';
import 'package:mylove/util/sp_util.dart';

//启动引导页面
class BootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BootPageState();
  }
}

class BootPageState extends State<BootPage> {
  List<Widget> _bannerList = new List();

  //引导页图片资源
  List<String> _guideList = [
    ImageUtil.getImgPath('icon_guide_1'),
    ImageUtil.getImgPath('icon_guide_2'),
    ImageUtil.getImgPath('icon_guide_3')
  ];

  @override
  void initState() {
    _initBannerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
          children: <Widget>[
            new Offstage(
              offstage: false,
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
          ]
      ),
    );
  }

  //初始化Banner数据
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
                    SpUtil.putBool(Constant.has_skip_key_guide, true);
                    Application.navigateTo(context: context,
                        route: Routes.MAIN_PAGE,
                        clearStack: true);
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
}