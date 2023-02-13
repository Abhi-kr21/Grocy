import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/constants/database.dart';
import 'package:store/models/address_model.dart';

class AddressController extends ChangeNotifier {
  AddressModel? address;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  setaddress(
      {required String state,
      required String city,
      required String addressline,
      required String pincode}) async {
    AddressModel address = AddressModel(
        addressid: uid,
        state: state,
        city: city,
        addressline: addressline,
        pincode: pincode);
    await addressdb.doc(uid).set(address.tojson());
    notifyListeners();
  }

  fetchAddress() async {
    var addressSnapshot = await addressdb.doc(uid).get();
    address = AddressModel.fromJson(addressSnapshot);
    notifyListeners();
  }

  updateAddress(
      {required String state,
      required String city,
      required String addressline,
      required String pincode}) async {
    print(state);
    await addressdb.doc(uid).update({
      'state': state,
      'city': city,
      'addressline': addressline,
      'pincode': pincode,
    });
    address!.addressline = addressline;
    address!.city = city;
    address!.pincode = pincode;
    address!.state = state;
    print("address updated");
    notifyListeners();
  }
}
