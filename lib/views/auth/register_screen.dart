import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:thread_app/controllers/auth_controller.dart';
import 'package:thread_app/widgets/auth/auth_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final AuthController authController = Get.put(AuthController());

  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

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
                    "Regsiter",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome To threads World!",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                AuthTextField(
                  label: "Name",
                  textEditingController: nameController,
                  validator:
                      ValidationBuilder().minLength(3).maxLength(20).build(),
                ),
                AuthTextField(
                  label: "Email",
                  textEditingController: emailController,
                  validator: ValidationBuilder().email().build(),
                ),
                AuthTextField(
                  label: "Password",
                  textEditingController: passwordController,
                  validator: ValidationBuilder()
                      .regExp(regex, "Use A Strong Password")
                      .build(),
                ),
                AuthTextField(
                  label: "Confirm Password",
                  textEditingController: confirmPasswordController,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return "Confirm Passowrd And Password Must Match";
                    }
                  },
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
                        authController.register(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      }
                    },
                    child: Obx(
                      () => Text(
                        authController.isLoading.value
                            ? "Processing...."
                            : "Regsiter",
                      ),
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: "Already have an account?",
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed("/login"),
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        text: " Login",
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
