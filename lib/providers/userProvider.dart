import 'package:flutter/material.dart';
import 'package:master_project/data/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get getUser => _user!;
  Future<void> refreshUser() async {

  }
}