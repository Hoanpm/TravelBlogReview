import 'package:flutter/material.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/common/bigButton.dart';
import 'package:travelblog/features/auth/view/register_view.dart';
import 'package:travelblog/features/pages/home/view/home_view.dart';

class StartView extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const StartView());
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 50,),
                const Text(
                  "Khám phá du lịch của Việt Nam ngay",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: "noto",
                    fontWeight:FontWeight.bold
                  ),
                ),
                const SizedBox(height: 50,),
                BigButton(
                  onTap: () 
                  {
                    Navigator.push(context, RegisterView.route());
                  }, 
                  label: "Tạo tài khoản ngay"
                ),
                const SizedBox(height: 50,),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    HomeView()), (Route<dynamic> route) => false);
                  },
                child: const Text(
                  'Trải nghiệm mà không cần đăng nhập',
                  style: TextStyle(
                    color: PJcolor.buttonColor,
                    fontFamily: "noto",
                    fontSize: 16  
                  ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}