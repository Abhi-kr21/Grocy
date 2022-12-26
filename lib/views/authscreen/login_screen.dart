import 'package:flutter/material.dart';
import 'package:store/constants/color_contsants.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/views/auth_textfields.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var space = const SizedBox(
    height: 15,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: authBackground,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/login.png",
                height: 300,
                width: 500,
              ),
              space,
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      letterSpacing: 1.2,
                      color: Colors.white),
                ),
              ),
              space,
              space,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AuthTextField(
                  label: "Email",
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: Colors.white60,
                  ),
                ),
              ),
              space,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: AuthTextField(
                    label: "Password",
                    prefixIcon: Icon(Icons.password, color: Colors.white60)),
              ),
              space,
              Padding(
                padding: const EdgeInsets.only(left: 17),
                child: Text(
                  "Forgot password",
                  style: TextStyle(fontSize: 15, color: Colors.white60),
                ),
              ),
              space,
              Center(
                child: SizedBox(
                  width: displayWidth(context) * 0.5,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: authMaterialButtonColor,
                    onPressed: () {},
                    child: Text("Submit"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
