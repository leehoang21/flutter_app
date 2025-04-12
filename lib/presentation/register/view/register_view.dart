import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/text_button.dart';
import '../../widgets/text_filed_widget.dart';
import '../bloc/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final TextEditingController controllerName = TextEditingController();
    final TextEditingController controllerStk = TextEditingController();

    final TextEditingController controllerPassword = TextEditingController();
    final TextEditingController controllerPin = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
              TextFieldWidget(
                controller: controllerName,
                hintText: "Ho ten",
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: controllerStk,
                hintText: "stk",
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
              SecurityTextFieldWidget(
                controller: controllerPin,
                keyboardType: TextInputType.text,
                hintText: "pin code",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: TextButtonWidget(
                  onPressed: () async {
                    await context.read<RegisterCubit>().register(
                          controller.text,
                          controllerName.text,
                          controllerStk.text,
                          controllerPassword.text,
                          controllerPin.text,
                        );
                  },
                  title: "Register",
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: RichText(
                      text: TextSpan(
                    text: 'Đã có tài khoản? ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: "Đăng nhập",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushNamed(RouteList.loginScreen);
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
