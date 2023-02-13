import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/address_controller.dart';
import 'package:store/controller/user_controller.dart';
import 'package:store/models/address_model.dart';
import 'package:store/models/user_model.dart';
import 'package:store/views/common_ui/auth_textfields.dart';

class EditProfileScreen extends StatefulWidget {
  UserModel user;
  AddressModel address;
  EditProfileScreen({super.key, required this.user, required this.address});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController namecontroller = TextEditingController();

  TextEditingController pnumbercontroller = TextEditingController();

  //TextEditingController emailcontroller = TextEditingController();

  TextEditingController statecontroller = TextEditingController();

  TextEditingController pincodecontroller = TextEditingController();

  TextEditingController citycontroller = TextEditingController();

  TextEditingController addresscontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var space = SizedBox(
    height: 15,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller.text = widget.user.name;
    pnumbercontroller.text = widget.user.pnumber;
    // emailcontroller.text = widget.user.email;
    statecontroller.text = widget.address.state;
    pincodecontroller.text = widget.address.pincode;
    citycontroller.text = widget.address.city;
    addresscontroller.text = widget.address.addressline;
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController namecontroller =
    //     TextEditingController(text: user.name);

    print("build");
    // print(name);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        backgroundColor: Colors.amber[600],
        elevation: 0,
      ),
      body: Container(
        height: displayHeight(context),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.amber[600],
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 550,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              margin: EdgeInsets.only(bottom: 50, top: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textformfield(name: "Name", controller: namecontroller),
                      space,
                      textformfield(
                          name: "Phone number", controller: pnumbercontroller),
                      space,
                      textformfield(name: "State", controller: statecontroller),
                      space,
                      textformfield(name: "City", controller: citycontroller),
                      space,
                      textformfield(
                          name: "Pincode", controller: pincodecontroller),
                      space,
                      textformfield(
                          name: "Address", controller: addresscontroller),
                      space,
                      space,
                      Consumer<AddressController>(
                        builder: (context, addressController, child) {
                          return Consumer<UserController>(
                            builder: (context, usercontroller, child) {
                              return SizedBox(
                                width: displayWidth(context) * 0.4,
                                child: MaterialButton(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  color: Colors.amber[600],
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      print(" name " + namecontroller.text);
                                      await usercontroller.updateuser(
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        name: namecontroller.text,
                                        pnumber: (pnumbercontroller.text),
                                      );

                                      await addressController.updateAddress(
                                          state: statecontroller.text,
                                          city: citycontroller.text,
                                          addressline: addresscontroller.text,
                                          pincode: pincodecontroller.text);
                                    }

                                    Fluttertoast.showToast(
                                      msg: "Profile Updated",
                                      fontSize: 16,
                                      gravity: ToastGravity.SNACKBAR,
                                    );
                                  },
                                  child: Text("Submit"),
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget textformfield(
    {required String name, required TextEditingController controller}) {
  return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: name,
      ));
}
