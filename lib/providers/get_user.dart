import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../data/models/user_model.dart';

class UserDetail{

  User? user = FirebaseAuth.instance.currentUser ;
  FirebaseStorage storage = FirebaseStorage.instance;
  UserModel loginUser = UserModel();
  Future getActualUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value){
      this.loginUser =UserModel.fromMap(value.data());

    });
    return loginUser;
  }

}