import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/constants/color_contsants.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/auth_screen_controller.dart';
import 'package:store/enums/enums.dart';
import 'package:store/models/user_model.dart';
import 'package:store/services/firebase/auth_service.dart';
import 'package:store/views/common_ui/auth_textfields.dart';
import 'package:store/views/screens/AddressScreen/address_screen.dart';
import '../homescreen/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final Authservice _auth = Authservice(FirebaseAuth.instance);
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final space = const SizedBox(height: 25);
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
                  padding: EdgeInsets.only(right: 60, top: 10),
                  child: Text(
                    "Create a Account",
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
                    prefixIcon: const Icon(
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
                const SizedBox(
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
                    keyboardtype: TextInputType.number,
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
                      } else if (value.length < 10) {
                        return "Phone number cannot be less than 10";
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AuthTextField(
                    controller: passwordController,
                    label: "Password",
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.white60,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password cannot be empty";
                      }
                    },
                  ),
                ),
                space,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AuthTextField(
                    controller: confirmpasswordController,
                    label: "Confirm Password",
                    prefixIcon: const Icon(
                      Icons.security,
                      color: Colors.white60,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "confirm password cannot be empty";
                      } else if (passwordController.text !=
                          confirmpasswordController.text) {
                        return "Confirm password should be same as password";
                      }
                    },
                  ),
                ),
                space,
                //  space,
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
                          print("validate");
                          if (_formKey.currentState!.validate()) {
                            controller.startSigningUp();
                            final nav = Navigator.of(context);
                            final sms = ScaffoldMessenger.of(context);
                            final dynamic Signupresponse = await _auth.signUp(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                            controller.stopSigningUp();

                            if (Signupresponse.runtimeType == UserCredential) {
                              UserCredential credential =
                                  Signupresponse as UserCredential;
                              //  UserCredential credential = Signupresponse;
                              //Creating a user object and assigning the values to it.
                              UserModel user = UserModel(
                                  userid: credential.user!.uid,
                                  name: nameController.text,
                                  pnumber: phonenumberController.text,
                                  email: emailController.text,
                                  joinedon: Timestamp.now());

                              /// Adding the user object to the firestore database.
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(credential.user!.uid)
                                  .set(user.tojson());
                              // await FirebaseFirestore.instance
                              //     .collection("user2")
                              //     .doc()
                              //     .collection("user1")
                              //     .doc()
                              //     .set(user.tojson());
                              await prefs.then(
                                  (value) => value.setBool("login", true));
                              nav.pushReplacement(MaterialPageRoute(
                                  builder: ((context) => AddressScreen())));
                            } else {
                              String errorMessage = Signupresponse;
                              sms.showSnackBar(
                                  SnackBar(content: Text(errorMessage)));
                            }
                          }
                        },
                        child: const Text("Submit"),
                      );
                    })),
                  ),
                ),
                space,

                Consumer<AuthScreenController>(
                    builder: ((context, controller, child) {
                  var status = controller.signupStatus;
                  if (status == AuthSignupStatus.loading) {
                    return const CircularProgressIndicator(
                      color: authMaterialButtonColor,
                    );
                  } else {
                    return const SizedBox();
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
