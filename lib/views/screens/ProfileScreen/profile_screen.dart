import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/constants/color_contsants.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/services/firebase/auth_service.dart';
import 'package:store/views/screens/AuthScreen/auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final Authservice _auth = Authservice(FirebaseAuth.instance);
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  var space = SizedBox(
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  appBar: AppBar(title: Text("data")),
        body: Container(
            height: displayHeight(context),
            width: displayWidth(context),
            decoration: BoxDecoration(color: Colors.amber[600]),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: Container(
                    // white container
                    height: 500,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Listtile(
                            Licon: Icon(Icons.edit),
                            text: "Edit Profile",
                            Ticon: Icon(Icons.arrow_forward_ios),
                            tap: () {},
                          ),
                        ),
                        space,
                        Listtile(
                          Licon: Icon(Icons.heart_broken_outlined),
                          text: "Wishlist",
                          Ticon: Icon(Icons.arrow_forward_ios),
                          tap: () {},
                        ),
                        space,
                        Listtile(
                          Licon: Icon(Icons.headset_mic),
                          text: "Help Center",
                          Ticon: Icon(Icons.arrow_forward_ios),
                          tap: () {},
                        ),
                        space,
                        Listtile(
                          Licon: Icon(Icons.picture_as_pdf_rounded),
                          text: "Terms,Policies and Licenses",
                          Ticon: Icon(Icons.arrow_forward_ios),
                          tap: () {},
                        ),
                        space,
                        space,
                        SizedBox(
                          width: displayWidth(context) * 0.35,
                          child: ElevatedButton(
                              onPressed: () async {
                                await _auth.signOut();
                                await prefs.then(
                                    (value) => value.setBool("login", false));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => AuthScreen())));
                              },
                              child: Text("Logout")),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 90,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/login.png"),
                    radius: 80,
                    backgroundColor: authBackground,
                  ),
                ),
                Positioned(
                    top: 25,
                    left: 1,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back))),
              ],
            )));
  }
}

Widget Listtile(
    {required Icon Licon,
    required String text,
    required Icon Ticon,
    required void Function()? tap}) {
  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    elevation: 15,
    child: ListTile(
      onTap: tap,
      leading: Licon,
      trailing: Ticon,
      title: Text(text),
    ),
  );
}
