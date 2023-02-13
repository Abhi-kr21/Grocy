import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/constants/color_contsants.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/address_controller.dart';
import 'package:store/controller/user_controller.dart';
import 'package:store/enums/enums.dart';
import 'package:store/models/user_model.dart';
import 'package:store/services/firebase/auth_service.dart';
import 'package:store/views/screens/AuthScreen/auth_screen.dart';
import 'package:store/views/screens/ProfileScreen/edit_profile_screen.dart';
import 'package:store/views/screens/WishlistScreen/wishlist_screen.dart';

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
                Container(
                  // white container

                  height: 470,
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
                  margin: EdgeInsets.only(bottom: 70),
                  child: Consumer<UserController>(
                    builder: (context, usercontroller, child) {
                      if (usercontroller.userstatus == UserStatus.NOTSET) {
                        usercontroller.setuser();
                      }
                      switch (usercontroller.userstatus) {
                        case UserStatus.SET:
                          return Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 90),
                                  child: Consumer<AddressController>(
                                    builder:
                                        (context, addresscontroller, child) {
                                      return Listtile(
                                        Licon: Icon(Icons.edit),
                                        text: "Edit Profile",
                                        Ticon: Icon(Icons.arrow_forward_ios),
                                        tap: () async {
                                          await addresscontroller
                                              .fetchAddress();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfileScreen(
                                                  address: addresscontroller
                                                      .address!,
                                                  user: usercontroller.user!,
                                                ),
                                              ));
                                        },
                                      );
                                    },
                                  )),
                              space,
                              Listtile(
                                Licon: Icon(Icons.favorite_border),
                                text: "Wishlist",
                                Ticon: Icon(Icons.arrow_forward_ios),
                                tap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WishListScreen(),
                                      ));
                                },
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
                              Consumer<UserController>(
                                builder: (context, usercontroller, child) {
                                  return SizedBox(
                                    width: displayWidth(context) * 0.40,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber[600],
                                            elevation: 15,
                                            foregroundColor: Colors.black87),
                                        onPressed: () async {
                                          await _auth.signOut();
                                          await prefs.then((value) =>
                                              value.setBool("login", false));
                                          usercontroller.userstatus =
                                              UserStatus.NOTSET;
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      AuthScreen())));
                                        },
                                        child: Text("Logout")),
                                  );
                                },
                              )
                            ],
                          );
                        case UserStatus.LOADING:
                          return Center(child: CircularProgressIndicator());
                        case UserStatus.NOTSET:
                          return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Positioned(
                  top: displayHeight(context) * 0.15,
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 15,
    child: ListTile(
      onTap: tap,
      leading: Licon,
      trailing: Ticon,
      title: Text(text),
    ),
  );
}
