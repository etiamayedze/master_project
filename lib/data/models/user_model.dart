import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel {

  String? uid;
  String? email;
  String? nom;
  String? prenom;
  String? username;
  String imgUrl;
  String? facture;
  String? demolink;
  String? ville;
  String? pays;
  String? bio;

  UserModel(
      {this.uid,
      this.email,
      this.nom,
      this.prenom,
      this.username,
      this.imgUrl = "",
      this.facture,
      this.demolink,
      this.ville,
      this.pays,
      this.bio});

//retour serveur
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      nom: map['nom'],
      prenom: map['prenom'],
      username: map['username'],
      imgUrl: map['imgUrl'],
      facture: map['facture'],
      demolink: map['demolink'],
      ville: map['ville'],
      pays: map['pays'],
      bio: map['bio'],
    );
  }

//envoie vers serveur
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'username': username,
      'imgUrl': imgUrl,
      'facture': facture,
      'demolink': demolink,
      'ville': ville,
      'pays': pays,
      'bio': bio,
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
