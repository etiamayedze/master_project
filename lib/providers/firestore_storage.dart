import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
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

class StorageMethods{

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async{
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask ;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
// to post an image in folder
// String potoUrl = await StorageMethods().uploadImageToStorage('nom du dossier', file, false)
}
