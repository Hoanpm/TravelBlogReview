import 'package:flutter/material.dart';

class KeyboardController extends StatefulWidget {
  final Widget child;

  KeyboardController({required this.child});

  static bool isKeyboardVisible(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.viewInsets.bottom > 0;
  }

  @override
  _KeyboardControllerState createState() => _KeyboardControllerState();
}

class _KeyboardControllerState extends State<KeyboardController> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}