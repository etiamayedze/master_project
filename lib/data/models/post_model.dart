class PostModel{
  String? uid;
  String? description;
  String? userId;
  String? postId;
  final datePubliched;
  String? postUrl;


  PostModel({this.uid, this.description, this.userId, this.postId, this.datePubliched, this.postUrl});

  //retour serveur
  factory PostModel.fromMap(map){
    return PostModel(
        uid:map['uid'],
        description:map['description'],
        userId:map['userId'],
        datePubliched:map['datePubliched'],
        postUrl:map['postUrl'],
    );
  }

  //envoie vers le serveur
  Map<String, dynamic> toMap(){
    return{
      'uid':uid,
      'description':description,
      'userId':userId,
      'postId':postId,
      'datePubliched':datePubliched,
      'postUrl':postUrl
    };
  }

}