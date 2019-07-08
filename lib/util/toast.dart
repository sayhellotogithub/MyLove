import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';


class Toast {
  static show(String msg, {
    BuildContext context,
    duration = 2000,
    ToastPosition position,
    TextStyle textStyle,
    EdgeInsetsGeometry textPadding,
    Color backgroundColor,
    double radius,
    VoidCallback onDismiss,
    TextDirection textDirection,
    bool dismissOtherToast = false,
    TextAlign textAlign,
  }) {
    showToast(
      msg,
      duration: Duration(milliseconds: duration),
      dismissOtherToast: dismissOtherToast,
      context: context,
      position: position,
      textPadding: textPadding,
      backgroundColor: backgroundColor,
      radius: radius,
      onDismiss: onDismiss,
      textDirection: textDirection,
      textAlign: textAlign,
    );
  }

  static cancelToast() {
    dismissAllToast();
  }
}
