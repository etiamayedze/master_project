class UserModel{
  String? uid;
  String? email;
  String? nom;
  String? prenom;
  String? username;
  String? imgUrl;
  String? facture;
  String? demolink;
  List? followers;
  List? following;

  UserModel({this.uid, this.email, this.nom, this.prenom, this.username, this.imgUrl = "", this.facture, this.demolink, this.followers, this.following,});


//retour serveur
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      nom: map['nom'],
      prenom: map['prenom'],
      username: map['username'],
      imgUrl: map['imgUrl'],
      facture: map['facture'],
      demolink: map['demolink'],
      followers: map['followers'],
      following: map['following'],
    );
  }

//envoie vers serveur
  Map<String,dynamic> toMap(){
    return{
      'uid': uid,
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'username': username,
      'imgUrl': imgUrl,
      'facture': facture,
      'demolink': demolink,
      'followers': followers,
      'following': following,
    };
  }
}