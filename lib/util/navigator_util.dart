import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:mylove/page/home/home_page.dart';

class NavigatorUtil {

  static void pushPage(BuildContext context, Widget page, {String pageName}) {
    if (context == null || page == null || ObjectUtil.isEmpty(pageName)) return;
    Navigator.push(
        context, new CupertinoPageRoute<void>(builder: (ctx)
    =>
    page
    )
    );
  }


  /// Replace the current route of the navigator by pushing the route named
  static void pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }
 static void pushAndRemoveUntil(BuildContext context,String routeName){

 }
  static void navigatorToMain(BuildContext context) {
    Navigator.of(context).push(new CupertinoPageRoute<void>(builder: (ctx)
    =>
    new HomePage()
    )
    );
  }

//  static void pushWeb(BuildContext context,
//      {String title, String titleId, String url, bool isHome: false}) {
//    if (context == null || ObjectUtil.isEmpty(url)) return;
//    if (url.endsWith(".apk")) {
//      launchInBrowser(url, title: title ?? titleId);
//    } else {
//      Navigator.push(
//          context,
//          new CupertinoPageRoute<void>(
//          builder: (ctx)
//      =>
//      new WebScaffold(
//        title: title,
//        titleId: titleId,
//        url: url,
//      )
//    )
//    );
//  }
//  }

//  static void pushTabPage(BuildContext context,
//      {String labelId, String title, String titleId, TreeModel treeModel}) {
//    if (context == null) return;
//    Navigator.push(
//        context,
//        new CupertinoPageRoute<void>(
//        builder: (ctx) => new BlocProvider<TabBloc>(
//      child: new TabPage(
//        labelId: labelId,
//        title: title,
//        titleId: titleId,
//        treeModel: treeModel,
//      ),
//      bloc: new TabBloc(),
//    )));
//  }

//  static Future<Null> launchInBrowser(String url, {String title}) async {
//    if (await canLaunch(url)) {
//      await launch(url, forceSafariVC: false, forceWebView: false);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }
}