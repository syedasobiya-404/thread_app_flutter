import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:thread_app/controllers/auth_controller.dart';
import 'package:thread_app/widgets/auth/auth_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  height: 70,
                  "./assets/images/logo.png",
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                AuthTextField(
                  label: "Email",
                  textEditingController: emailController,
                  validator: ValidationBuilder().email().build(),
                ),
                AuthTextField(
                  label: "Password",
                  textEditingController: passwordController,
                  validator: ValidationBuilder().required().build(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: Size(
                        double.infinity,
                        55,
                      ),
                    ),
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        authController.login(emailController.text.trim(),
                            passwordController.text.trim());
                      }
                    },
                    child: Obx(
                      () => Text(
                        authController.isLoading.value
                            ? "Processing...."
                            : "Login",
                      ),
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: "Don't have an account?",
                    children: [
                      TextSpan(
                        // named routing
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed("/register"),
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        text: " Register",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
