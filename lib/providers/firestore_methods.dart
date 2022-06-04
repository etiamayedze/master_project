import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
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
      String username,
      String profImage,
      ) async {
    String res = "some error";
    try{
      String postImage = await StorageMethods().uploadImageToStorage('posts', file, true) ;
      String postId = const Uuid().v1();

      PostModel post = PostModel(
        description: description,
        uid: uid,
        datePubliched: DateTime.now(),
        postUrl: postImage,
        postId: postId,
        likes: [],
        username: username,
        profImage: profImage,
      );
      _firestore.collection('posts').doc(postId).set(
        post.toMap(),
      );
      res = "success";
    }catch(err){
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String? uid, List likes) async {
    String res = "some error occurred";
    try{
      if(likes.contains(uid)){
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      }else{
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
      res = 'success';
    }catch(err){
      res = err.toString();
    }
    return res;
  }

  //post comment
  Future<String> postComment(String postId, String text, String? uid, String? name, String profilePic) async {
    String res = "somme error occurred";
    try{
      if(text.isNotEmpty) {
        String commentId = const Uuid().v1();
       await _firestore
           .collection('posts')
           .doc(postId)
           .collection('comments')
           .doc(commentId)
           .set({
          'profilePic':profilePic,
          'name':name,
          'uid':uid,
          'text': text,
          'commentId':commentId,
          'datePubliched': DateTime.now(),
        });
        res = 'succes s';
      }else{
        res = 'Please enter text';
      }
    }catch(err){
      res = err.toString();
    }
    return res;
  }

  // deleting post

Future<String> deletePost(String postId)async {
    String res = "some error occurred";
    try{
      await _firestore.collection('posts').doc(postId).delete();
      res ='success';
    }catch(err){
     res = err.toString();
    }
    return res;
}

}