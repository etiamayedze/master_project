import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:master_project/data/models/user_model.dart';

class StorageHelper {
  CollectionReference comments =
  FirebaseFirestore.instance.collection('comment');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  var uid = Hive.box("connection").get("uid");

  Future<String?> getUserName(userId) async {
    UserModel res = new UserModel();
    await users.doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        res = UserModel.fromMap(documentSnapshot.data());
      }
    });
    return res.nom;
  }
}
