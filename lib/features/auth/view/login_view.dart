// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/common/bigButton.dart';
import 'package:travelblog/features/auth/view/register_view.dart';
import 'package:travelblog/features/auth/widget/auth_field.dart';
import 'package:travelblog/features/auth/widget/custom_alert_box.dart';
import 'package:travelblog/features/pages/home/view/home_view.dart';

final supabase = Supabase.instance.client;

class LoginView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());

  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> signIn() async {
    try {
      await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (!context.mounted) return;
      Navigator.push(context, HomeView.route());
    } on AuthException catch (e) {
      print(e);
      var dialog = const CustomAlertDialog(
          title: "Notice", message: "Thông tin đăng nhập chưa chính xác");
      showDialog(context: context, builder: (BuildContext context) => dialog);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Trở lại',
              style: TextStyle(
                  fontFamily: "noto",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: PJcolor.buttonColor),
            ),
            titleSpacing: 0),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    "Đăng Nhập",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Noto"),
                  ),
                  const SizedBox(height: 50),
                  AuthField(
                    controller: emailController,
                    hintText: "Email",
                    ishiddenText: false,
                  ),
                  AuthField(
                    controller: passwordController,
                    hintText: "Password",
                    ishiddenText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BigButton(
                      onTap: () {
                        if (emailController.text != "" &&
                            passwordController.text != "") {
                          signIn();
                        } else {
                          var dialog = const CustomAlertDialog(
                              title: "Notice",
                              message: "Vui lòng nhập đầy đủ thông tin!");
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => dialog);
                        }
                      },
                      label: "Đăng Nhập"),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Bạn chưa có tài khoản?",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "noto"),
                          children: [
                        TextSpan(
                            text: ' Đăng ký',
                            style: const TextStyle(
                                color: PJcolor.buttonColor,
                                fontSize: 16,
                                fontFamily: "noto"),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, RegisterView.route());
                              })
                      ])),
                  const SizedBox(
                    height: 140,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
