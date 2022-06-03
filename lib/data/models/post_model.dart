class PostModel{
  String? uid;
  String? description;
  String? postId;
  final datePubliched;
  final likes;
  String? postUrl;
  String? username;
  String? profImage;


  PostModel({this.uid, this.description,this.postId, this.datePubliched, this.postUrl, this.likes, this.username, this.profImage});

  //retour serveur
  factory PostModel.fromMap(map){
    return PostModel(
      uid:map['uid'],
      description:map['description'],
      datePubliched:map['datePubliched'],
      postUrl:map['postUrl'],
        likes: map['likes'],
      username: map['username'],
      profImage: map['profImage'],
    );
  }

  //envoie vers le serveur
  Map<String, dynamic> toMap(){
    return{
      'uid':uid,
      'description':description,
      'postId':postId,
      'datePubliched':datePubliched,
      'postUrl':postUrl,
      'likes':likes,
      'username':username,
      'profImage':profImage,
    };
  }

}