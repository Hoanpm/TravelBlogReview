import 'package:flutter/material.dart';
import 'package:travelblog/color/color.dart';

class SearchText extends StatelessWidget {
  final String inputString;
  const SearchText({
    super.key,
    required this.inputString
    });

  @override
  Widget build(BuildContext context) {
    return  Text(
      inputString,
      style: const TextStyle(
        color: PJcolor.buttonColor,
        fontFamily: 'noto',
        fontSize: 18,
        fontWeight: FontWeight.w500
      ),
    );
  }
}
