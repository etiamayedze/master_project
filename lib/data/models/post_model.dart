class PostModel{
  final String uid;
  final String description;
  final String postId;
  final DateTime datePubliched;
  final likes;
  final String postUrl;
  final String username;
  final String profImage;


  const PostModel({required this.uid,required this.description,required this.postId,required this.datePubliched,required this.postUrl, this.likes,required this.username,required this.profImage});

  //retour serveur
  factory PostModel.fromMap(map){
    return PostModel(
      uid:map['uid'],
      postId: map['postId'],
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