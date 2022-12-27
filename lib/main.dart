import 'package:flutter/material.dart';
import 'package:store/views/authscreen/auth_screen.dart';
import 'package:store/views/authscreen/login_screen.dart';
import 'package:store/views/authscreen/sigup_screen.dart';
import 'package:store/views/homescreen/home_screen.dart';

void main() {
  runApp(const Store());
}

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}
