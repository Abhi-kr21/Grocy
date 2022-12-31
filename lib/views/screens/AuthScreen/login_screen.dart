import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/constants/color_contsants.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/auth_screen_controller.dart';
import 'package:store/enums/enums.dart';
import 'package:store/services/firebase/auth_service.dart';
import 'package:store/views/common_ui/auth_textfields.dart';
import 'package:store/views/screens/homescreen/home_screen.dart';

class LoginScreen extends StatelessWidget {
  final Authservice _auth = Authservice(FirebaseAuth.instance);
  TextEditingController emailController = TextEditingController();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginScreen({super.key});
  var space = const SizedBox(
    height: 15,
  );
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/login.png",
                  height: 250,
                  width: 500,
                ),
                space,
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: AuthTextField(
                    controller: passwordController,
                    label: "Password",
                    prefixIcon: Icon(Icons.password, color: Colors.white60),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                space,
                const Padding(
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
                    child: Consumer<AuthScreenController>(
                      builder: ((context, controller, child) {
                        return MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: authMaterialButtonColor,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              controller.startLogin();
                              final nav = Navigator.of(context);
                              dynamic loginResponse = await _auth.signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());
                              //print("email:${emailController.text}");
                              controller.stopLogin();
                              if (loginResponse.runtimeType == UserCredential) {
                                nav.push(MaterialPageRoute(
                                    builder: ((context) => HomeScreen())));
                                prefs.then(
                                    (value) => value.setBool("login", true));
                              } else {
                                String s = loginResponse;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(s)));
                              }
                            }
                          },
                          child: Text("Submit"),
                        );
                      }),
                    ),
                  ),
                ),
                space,
                Consumer<AuthScreenController>(
                    builder: ((context, controller, child) {
                  var status = controller.loginStatus;
                  if (status == AuthLoginStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: authMaterialButtonColor,
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
