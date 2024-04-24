import 'package:flutter/material.dart';
import 'package:travelblog/color/color.dart';

class BigButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  
  const BigButton({
    super.key, 
    required this.onTap, 
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(350, 55),
        backgroundColor : PJcolor.buttonColor, 
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white, // Màu văn bản
          fontFamily: "noto",
          fontSize: 25, // Cỡ chữ
          fontWeight: FontWeight.bold, // Độ đậm của chữ
        ),
      ),
    );
  }
}
