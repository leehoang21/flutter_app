import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/text_button.dart';
import '../../widgets/text_filed_widget.dart';
import '../bloc/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final TextEditingController controllerPassword = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFieldWidget(
                controller: controller,
                hintText: "userName",
              ),
              const SizedBox(
                height: 10,
              ),
              SecurityTextFieldWidget(
                controller: controllerPassword,
                keyboardType: TextInputType.text,
                hintText: "password",
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: TextButtonWidget(
                  onPressed: () async {
                    await context.read<LoginCubit>().login(
                          controller.text,
                          controllerPassword.text,
                        );
                  },
                  title: "Login",
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: RichText(
                      text: TextSpan(
                    text: 'Chưa có tài khoản? ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: "Đăng ký",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushNamed(RouteList.registerScreen);
                          },
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
