import 'package:flutter/material.dart';
import 'package:travelblog/color/color.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const AuthField({
    super.key, 
    required this.controller,
    required this.hintText,
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.lightBlue,
            width: 3
          )
        ),
        contentPadding: const EdgeInsets.fromLTRB(0, 18, 18, 18),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: "noto",
          fontSize: 20,
          color: PJcolor.primaryColor,
        )
      ),
    );
  }
}