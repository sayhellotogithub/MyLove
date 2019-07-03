import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mylove/eventbus/event_bus.dart';
import 'package:mylove/route/common.dart';
import 'package:mylove/route/router.dart';

class Application {
  // ignore: undefined_class
  static Router router;
  static EventBus eventBus;

  static navigateTo(
      { @required BuildContext context, @required String route, transition = TransitionType
          .inFromRight }) {
    router.navigateTo(context, route, transition: transition);
  }
}