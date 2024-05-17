import 'package:flutter/material.dart';
import 'package:travelblog/color/color.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool ishiddenText;
  const AuthField(
      {super.key, required this.controller, required this.hintText, required this.ishiddenText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: ishiddenText,
      controller: controller,
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(0, 18, 18, 18),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: "noto",
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: PJcolor.primaryColor2,
          )),
    );
  }
}
