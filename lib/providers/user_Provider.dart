import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:master_project/data/models/user_model.dart';
import 'package:master_project/providers/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel?  _user;
  final AuthMethods _authMethods = AuthMethods();


  UserModel get getUser => _user!;
  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();

  }

}