import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/models/address_model.dart';

class UserModel {
  final String userid;
  String name;
  String pnumber;
  String email;
  final Timestamp joinedon;
  // List<AddressModel> addresses;
  UserModel(
      {required this.userid,
      required this.name,
      // required this.addresses,
      required this.pnumber,
      required this.email,
      required this.joinedon});
  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'pnumber': pnumber,
      'email': email,
      'joined on': joinedon,
      'user id': userid,
    };
  }

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    // print(json.data().toString());
    return UserModel(
        userid: json.data()!['user id'],
        name: json.data()!['name'],
        pnumber: json.data()!['pnumber'],
        email: json.data()!['email'],
        joinedon: json.data()!['joined on']);
  }
}
