import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:travelblog/color/color.dart";
import "package:travelblog/common/bigButton.dart";
import "package:travelblog/features/auth/view/login_view.dart";
import "package:travelblog/features/auth/widget/auth_field.dart";

final supabase = Supabase.instance.client;

class RegisterView extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const RegisterView());

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    repeatPasswordController.dispose();
    fullNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Trở lại',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "noto",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: PJcolor.buttonColor),
          ),
          titleSpacing: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    "Tạo tài khoản",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Noto"),
                  ),
                  const SizedBox(height: 20),
                  AuthField(
                    controller: fullNameController,
                    hintText: "Họ tên",
                  ),
                  AuthField(
                    controller: emailController,
                    hintText: "Email",
                  ),
                  AuthField(
                    controller: userNameController,
                    hintText: "Username",
                  ),
                  AuthField(
                    controller: passwordController,
                    hintText: "Mật khẩu",
                  ),
                  AuthField(
                    controller: repeatPasswordController,
                    hintText: "Nhập lại mật khẩu",
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BigButton(
                      onTap: () async {
                        final authResponse = await supabase.auth.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        await supabase.from('users').insert({
                          'id': authResponse.user?.id as String,
                          'email': authResponse.user?.email,
                          'fullName': fullNameController.text,
                          'username': userNameController.text,
                        });

                        if (!context.mounted) return;
                        Navigator.push(context, LoginView.route());
                      },
                      label: "Đăng Ký"),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Đã có tài khoản?",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "noto"),
                          children: [
                        TextSpan(
                          text: ' Đăng Nhập',
                          style: const TextStyle(
                              color: PJcolor.buttonColor,
                              fontSize: 16,
                              fontFamily: "noto"),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, LoginView.route());
                            },
                        )
                      ])),
                ],
              ),
            ),
          ),
        ));
  }
}
