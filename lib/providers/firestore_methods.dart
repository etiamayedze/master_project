import 'dart:js_util/js_util_wasm.dart';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:master_project/data/models/post_model.dart';
import 'package:master_project/providers/firestore_storage.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
      String description,
      Uint8List file,
      String uid,
      String userId,
      ) async {
    String res = "some error";
    try{
      String postImage = await StorageMethods().uploadImageToStorage('posts', file, true) ;
      String postId = const Uuid().v1();

      PostModel post = PostModel(
        description: description,
        uid: uid,
        userId: userId,
        datePubliched: DateTime.now(),
        postUrl: postImage,
        postId: postId,

      );
      _firestore.collection('Post').doc(postId).set(
        post.toMap(),
      );
      res = "success";
    }catch(err){
      res = err.toString();

    }
    return res;
  }
}