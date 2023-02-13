// datatabases

import 'package:cloud_firestore/cloud_firestore.dart';

var userDb = FirebaseFirestore.instance.collection("users");

var categoryDb = FirebaseFirestore.instance.collection("category");

var productDb = FirebaseFirestore.instance.collection("product");

var orderdb = FirebaseFirestore.instance.collection("orders");

var cartdb = FirebaseFirestore.instance.collection("cart");

var wishlistdb = FirebaseFirestore.instance.collection("wishlist");

var addressdb = FirebaseFirestore.instance.collection("address");
