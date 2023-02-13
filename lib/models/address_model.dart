import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String addressid;
  String state;
  String city;
  String addressline;
  String pincode;

  AddressModel(
      {required this.addressid,
      required this.state,
      required this.city,
      required this.addressline,
      required this.pincode});
  Map<String, dynamic> tojson() {
    return {
      'addressid': addressid,
      'state': state,
      'city': city,
      'addressline': addressline,
      'pincode': pincode,
    };
  }

  factory AddressModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    return AddressModel(
      addressid: json.data()!['addressid'],
      state: json.data()!['state'],
      city: json.data()!['city'],
      addressline: json.data()!['addressline'],
      pincode: json.data()!['pincode'],
    );
  }
}
