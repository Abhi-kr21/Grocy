import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/constants/database.dart';
import 'package:store/enums/enums.dart';
import 'package:store/models/user_model.dart';

class UserController extends ChangeNotifier {
  UserModel? user;
  UserStatus userstatus = UserStatus.NOTSET;
  setuser() async {
    await Future.delayed(Duration(microseconds: 1));
    userstatus = UserStatus.LOADING;
    notifyListeners();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    user = UserModel.fromJson(userDoc);
    print(user!.name);
    userstatus = UserStatus.SET;
    notifyListeners();
  }

  updateuser(
      {required String name,
      required String pnumber,
      required String uid}) async {
    await userDb.doc(uid).update({
      'name': name,
      'pnumber': pnumber,
    });
    user!.name = name;
    //user!.email = email;
    user!.pnumber = pnumber;
  }
}
