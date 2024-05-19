import 'package:flutter/material.dart';
import 'package:travelblog/color/color.dart';

class SearchText extends StatelessWidget {
  final String inputString;
  final Future<dynamic> Function() handleTap;  // Đặt kiểu dữ liệu là một hàm

  const SearchText({super.key, required this.inputString, required this.handleTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handleTap();  // Gọi hàm handleTap khi được nhấn
      },
      child: Text(
        inputString,
        style: const TextStyle(
            color: PJcolor.buttonColor,
            fontFamily: 'noto',
            fontSize: 18,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}