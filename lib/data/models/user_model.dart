  import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String? uid;
  String? email;
  String? nom;
  String? prenom;
  String? imgUrl;

  UserModel({this.uid,this.email,this.nom,this.prenom, this.imgUrl = ""});


//retour serveur
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      nom: map['nom'],
      prenom: map['prenom'],
      imgUrl: map['imgUrl'],
    );
  }

//envoie vers serveur
  Map<String,dynamic> toMap(){
    return{
      'uid': uid,
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'imgUrl': imgUrl
    };
  }


    static UserModel fromSnap(DocumentSnapshot snap) {
      var snapshot = snap.data() as Map<String, dynamic>;

      return UserModel(
        uid: snapshot["uid"],
        email: snapshot["email"],
        nom: snapshot["nom"],
        prenom: snapshot["prenom"],
        imgUrl: snapshot["imgUrl"],

      );
    }
}