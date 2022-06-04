import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master_project/data/models/message_model.dart';
import 'package:master_project/data/models/user_model.dart';
import 'package:master_project/services/auth_service.dart';

import 'auth_service.dart';

class DbServices{
  var userCollection = FirebaseFirestore.instance.collection('users');
  var messageCollection = FirebaseFirestore.instance.collection('messages');

  Stream<List<UserModel>> get getCurrentUser{
    return userCollection.where('uid', isEqualTo: AuthServices().user?.uid).snapshots().map((event) => event.docs.map((e) => UserModel.fromMap(e.data())).toList());

  }

  Stream<List<UserModel>> get getDiscussionUser{
      return userCollection.where('uid', isNotEqualTo: AuthServices().user?.uid).snapshots().map((event) => event.docs.map((e) => UserModel.fromMap(e.data())).toList());

  }

  Stream<List<Message>> getMessage(String receiverID, [bool myMessage = true]){
    return messageCollection
        .where('senderID',
          isEqualTo: myMessage?AuthServices().user?.uid: receiverID)
        .where('receiverID',
          isEqualTo: myMessage? receiverID: AuthServices().user?.uid)
        .snapshots()
        .map((event) =>
          event.docs.map((e) => Message.fromJson(e.data(), e.id)).toList());

  }

  Future<bool> sendMessage(Message msg)async{
    try{
      await messageCollection.doc().set(msg.toJson());
      return true;
    }
    catch(e){
      return false;
    }
  }
}
