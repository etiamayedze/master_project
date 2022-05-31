class PostModel{
  String? uid;
  String? description;
  String? postId;
  final datePubliched;
  String? postUrl;


  PostModel({this.uid, this.description,this.postId, this.datePubliched, this.postUrl});

  //retour serveur
  factory PostModel.fromMap(map){
    return PostModel(
      uid:map['uid'],
      description:map['description'],
      datePubliched:map['datePubliched'],
      postUrl:map['postUrl'],
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
    };
  }

}