/**
 * Loading 组件
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:mylove/componment/fading_circle.dart';

class LoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      itemBuilder: (_, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );
  }
}
