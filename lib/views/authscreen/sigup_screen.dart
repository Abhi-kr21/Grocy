import 'package:flutter/material.dart';
import 'package:store/constants/color_contsants.dart';
import 'package:store/views/auth_textfields.dart';

import '../../constants/heigth_width_constant.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  var space = const SizedBox(height: 25);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(Icons.arrow_back),
          //     ),
          backgroundColor: authBackground,
        ),
        backgroundColor: authBackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 60, top: 10),
                child: Text(
                  "Create a new Account",
                  style: TextStyle(
                      fontSize: 30, color: Colors.white, letterSpacing: 1.2),
                ),
              ),
              space,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AuthTextField(
                  label: "Name",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white60,
                  ),
                  maxlength: 30,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AuthTextField(
                    label: "Email",
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Colors.white60,
                    )),
              ),
              space,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AuthTextField(
                  label: "Phone number",
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.white60,
                  ),
                  maxlength: 10,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AuthTextField(
                    label: "Password",
                    prefixIcon: Icon(
                      Icons.key,
                      color: Colors.white60,
                    )),
              ),
              space,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AuthTextField(
                    label: "Confirm Password",
                    prefixIcon: Icon(
                      Icons.security,
                      color: Colors.white60,
                    )),
              ),
              space,
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
