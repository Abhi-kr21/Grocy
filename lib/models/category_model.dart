import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String? categoryid;
  String categoryname;
  String image;
  Category(
      {required this.categoryid,
      required this.categoryname,
      required this.image});
  Map<String, dynamic> tojson() {
    return {
      "categoryid": categoryid,
      "categoryname": categoryname,
      "image": image,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        categoryid: json['categoryid'],
        categoryname: json['categoryname'],
        image: json['image']);
  }
}
