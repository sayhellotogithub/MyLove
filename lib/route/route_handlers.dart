import 'package:flutter/material.dart';
import 'package:mylove/page/home/home_page.dart';
import 'package:mylove/route/common.dart';

var homeRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return HomePage();
    }
);