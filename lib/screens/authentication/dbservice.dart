import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master_project/data/models/user_model.dart';

class DbServices{
  var userCollection = FirebaseFirestore.instance.collection('users');

  Stream<List<UserModel>> get getDiscussionUser{
      return userCollection.snapshots().map((event) => event.docs.map((e) => UserModel.fromMap(e.data())).toList());

  }

}
