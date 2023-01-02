import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/models/user_model.dart';

class UserController extends ChangeNotifier {
  UserModel? user;
  setuser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    user = UserModel.fromJson(userDoc);
    print(user!.name);
    notifyListeners();
  }
}
