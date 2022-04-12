import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master_project/data/models/user_model.dart';
import 'package:master_project/screens/authentication/auth_service.dart';

class DbServices{
  var userCollection = FirebaseFirestore.instance.collection('users');

  Stream<List<UserModel>> get getDiscussionUser{
      return userCollection.where('uid', isNotEqualTo: AuthServices().user?.uid).snapshots().map((event) => event.docs.map((e) => UserModel.fromMap(e.data())).toList());

  }

}
