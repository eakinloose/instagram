import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.hintText,
    required this.isPassword,
    required this.keyboardType,
    required this.textEditingController,
  });

  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(16),
      ),
      keyboardType: keyboardType,
      obscureText: isPassword,
    );
  }
}
