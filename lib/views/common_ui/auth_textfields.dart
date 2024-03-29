import 'package:flutter/material.dart';
import 'package:store/constants/color_contsants.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon? prefixIcon;
  final suffixIcon;
  final maxlength;
  final keyboardtype;

  /// A function that takes a string and returns a string.
  String? Function(String?)? validator;

  AuthTextField(
      {required this.controller,
      required this.label,
      this.prefixIcon,
      this.suffixIcon,
      this.maxlength,
      required this.validator,
      this.keyboardtype});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardtype,
      controller: controller,
      maxLength: maxlength,
      validator: validator,
      cursorColor: Colors.white30,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        counterStyle: TextStyle(color: Colors.white60),
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: authTextBoxColor,
        labelStyle: TextStyle(
          color: Colors.white60,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: authTextBoxBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: authTextBoxBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: authTextBoxBorderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
