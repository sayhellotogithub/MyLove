
import 'package:flutter/material.dart';
import 'package:mylove/mvp/base_state.dart';

abstract class BaseWidget extends StatefulWidget {

  BaseState baseWidgetState;

  @override
  BaseState createState() {
    baseWidgetState = getState();
    return baseWidgetState;
  }

  BaseState getState();

}