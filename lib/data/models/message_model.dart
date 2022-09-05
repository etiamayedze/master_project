import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master_project/services/auth_service.dart';

class Messenger{
  String? uid;
  String? contenu;
  String? senderID;
  String? receiverID;
  Timestamp? deliveryDate;

  Messenger({this.uid, this.contenu, this.senderID, this.receiverID, this.deliveryDate});

  Messenger.fromJson(Map<String, dynamic> json, String id){
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