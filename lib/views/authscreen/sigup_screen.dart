import 'package:flutter/material.dart';
import 'package:store/constants/color_contsants.dart';
import 'package:store/views/common_ui/auth_textfields.dart';

import '../../constants/heigth_width_constant.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var space = const SizedBox(height: 25);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: authBackground,
          elevation: 0,
        ),
        backgroundColor: authBackground,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(
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
                    controller: nameController,
                    label: "Name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white60,
                    ),
                    maxlength: 30,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AuthTextField(
                    controller: emailController,
                    label: "Email",
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Colors.white60,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                space,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AuthTextField(
                    controller: phonenumberController,
                    label: "Phone number",
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.white60,
                    ),
                    maxlength: 10,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone number cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AuthTextField(
                    controller: passwordController,
                    label: "Password",
                    prefixIcon: Icon(
                      Icons.key,
                      color: Colors.white60,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                space,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AuthTextField(
                    controller: confirmpasswordController,
                    label: "Confirm Password",
                    prefixIcon: Icon(
                      Icons.security,
                      color: Colors.white60,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "confirm password cannot be empty";
                      }
                      return null;
                    },
                  ),
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print(emailController.text);
                          print("validate");

                          if (passwordController.value !=
                              confirmpasswordController.value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'password and confirm password should be same')));
                          }
                        } else {
                          print("not validate");
                        }
                      },
                      child: Text("Submit"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
