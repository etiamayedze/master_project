import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master_project/services/auth_service.dart';

class Message{
  String? uid;
  String? contenu;
  String? senderID;
  String? receiverID;
  Timestamp? deliveryDate;

  Message({this.uid, this.contenu, this.senderID, this.receiverID, this.deliveryDate});

  Message.fromJson(Map<String, dynamic> json, String id){
    uid = id;
    contenu = json['contenu'];
    senderID = json['senderID'];
    receiverID = json['receiverID'];
    deliveryDate = json['deliveryDate'];
  }

  Map<String, dynamic> toJson(){
    return {
      'contenu': contenu,
      'senderID': senderID,
      'receiverID': receiverID,
      'deliveryDate': deliveryDate,
    };
  }

  bool get itsMe => AuthServices().user!.uid == senderID;
}