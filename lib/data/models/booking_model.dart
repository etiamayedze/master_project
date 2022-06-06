class BookingModel {
  final String book_id;
  final String uid_user;
  final String uid_dj;
  final String commentaire;
  final int accept;
  final String date_prestation;
  final String heure_prestation;

  BookingModel({
    required this.book_id,
    required this.uid_user,
    required this.uid_dj,
    required this.commentaire,
    required this.accept,
    required this.date_prestation,
    required this.heure_prestation,
  });

  //retour serveur
  factory BookingModel.fromMap(map) {
    return BookingModel(
      book_id: map['book_id'],
      uid_user: map['uid_user'],
      uid_dj: map['uid_dj'],
      commentaire: map['commentaire'],
      accept: map['accept'],
      date_prestation: map['date_prestation'],
      heure_prestation: map['heure_prestation'],
    );
  }

  //envoie vers le serveur
  Map<String, dynamic> toMap() {
    return {
      'book_id': book_id,
      'uid_user': uid_user,
      'uid_dj': uid_dj,
      'commentaire': commentaire,
      'accept': accept,
      'date_prestation': date_prestation,
      'heure_prestation': heure_prestation
    };
  }
}
