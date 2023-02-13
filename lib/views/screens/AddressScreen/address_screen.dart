import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/constants/color_contsants.dart';
import 'package:store/constants/heigth_width_constant.dart';
import 'package:store/controller/address_controller.dart';
import 'package:store/views/common_ui/auth_textfields.dart';
import 'package:store/views/screens/HomeScreen/home_screen.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});
  TextEditingController statecontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final space = const SizedBox(height: 25);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authBackground,
      appBar: AppBar(
        backgroundColor: authBackground,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 60, top: 10),
                child: Text(
                  "Enter your address",
                  style: TextStyle(
                      fontSize: 30, color: Colors.white, letterSpacing: 1.2),
                ),
              ),
              space,
              space,
              space,
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AuthTextField(
                  controller: statecontroller,
                  label: "State",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "state cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              space,
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AuthTextField(
                  controller: citycontroller,
                  label: "City",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "State cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              space,
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AuthTextField(
                  controller: pincodecontroller,
                  label: "Pincode",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Pincode cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              space,
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AuthTextField(
                  controller: addressController,
                  label: "Address",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Address cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              space,
              const SizedBox(
                height: 5,
              ),
              Consumer<AddressController>(
                builder: (context, addresscontroller, child) {
                  return SizedBox(
                    width: displayWidth(context) * 0.5,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await addresscontroller.setaddress(
                              state: statecontroller.text,
                              city: citycontroller.text,
                              addressline: addressController.text,
                              pincode: pincodecontroller.text);
                        }

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                      },
                      color: authMaterialButtonColor,
                      child: Text("Continue"),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
