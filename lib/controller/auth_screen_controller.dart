import 'package:store/enums/enums.dart';
import 'package:flutter/material.dart';

class AuthScreenController extends ChangeNotifier {
  AuthSignupStatus signupStatus = AuthSignupStatus.notloading;
  AuthLoginStatus loginStatus = AuthLoginStatus.notloading;

  startSigningUp() {
    signupStatus = AuthSignupStatus.loading;
    notifyListeners();
  }

  stopSigningUp() {
    signupStatus = AuthSignupStatus.notloading;
    notifyListeners();
  }

  startLogin() {
    loginStatus = AuthLoginStatus.loading;
    notifyListeners();
  }

  stopLogin() {
    loginStatus = AuthLoginStatus.notloading;
    notifyListeners();
  }
}
