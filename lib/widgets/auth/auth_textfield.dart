import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final String? Function(String?) validator;
  const AuthTextField(
      {super.key,
      required this.label,
      required this.textEditingController,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        validator: validator,
        controller: textEditingController,
        decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                14,
              ),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            contentPadding: EdgeInsets.all(
              20,
            )),
      ),
    );
  }
}
