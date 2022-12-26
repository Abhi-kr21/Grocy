import 'package:flutter/material.dart';
import 'package:store/constants/color_contsants.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final Icon prefixIcon;
  final suffixIcon;
  final maxlength;
  AuthTextField({
    required this.label,
    required this.prefixIcon,
    this.suffixIcon,
    this.maxlength,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxlength,
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
      ),
    );
  }
}
