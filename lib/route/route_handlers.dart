import 'package:flutter/material.dart';
import 'package:mylove/page/boot_page.dart';
import 'package:mylove/page/home/home_page.dart';
import 'package:mylove/page/main_page.dart';
import 'package:mylove/page/splash_page.dart';
import 'package:mylove/route/common.dart';

var homeRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return HomePage();
    }
);
var mainRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return MainPage();
    }
);

var splashRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SplashPage();
    }
);

var bootRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return BootPage();
    }
);