// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class WishList {
  List<String> productid;
  WishList({
    required this.productid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productid': productid,
    };
  }

  factory WishList.fromMap(Map<String, dynamic> map) {
    return WishList(
        productid: List<String>.from(
      (map['productid'] as List<dynamic>),
    ));
  }
}
