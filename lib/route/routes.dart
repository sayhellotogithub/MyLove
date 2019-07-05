import 'package:flutter/material.dart';
import 'package:mylove/route/common.dart';
import 'package:mylove/route/route_handlers.dart';
import 'package:mylove/route/router.dart';

class Routes {
  static const String HOME_PAGE = "home/HomePage";
  static const String MAIN_PAGE = "mainPage";
  static const String SPLASH_PAGE = "splashPage";

  static void configureRoutes(Router router) {
    router.define(MAIN_PAGE, handler: mainRouteHandler);
    router.define(HOME_PAGE, handler: homeRouteHandler);
    router.define(SPLASH_PAGE, handler: splashRouteHandler);
//    router.define(webview, handler: webviewRouteHandler);
//    router.define(videoDetail, handler: videoDetailRouteHandler);

    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
        });
  }

}