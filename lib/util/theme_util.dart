import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeUtil {
  static void setSystemUiOverlayStyle() {
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，
      // 是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
  // 默认主题色
  static const Color defaultColor =Colors.redAccent ;

  // 可选的主题色
  static const List<Color> supportColors = [const Color(0xFF5394FF), Colors.purple, Colors.orange, Colors.deepPurpleAccent, Colors.redAccent, Colors.blue, Colors.amber, Colors.green, Colors.lime, Colors.indigo, Colors.cyan, Colors.teal];

  // 当前的主题色
  static Color currentColorTheme = defaultColor;
}