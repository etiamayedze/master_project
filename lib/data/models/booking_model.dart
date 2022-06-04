
class Booking {
  String? uid_book;
  String? uid_user;
  String? uid_dj;
  String? commentaire;
  String? accept;
  String? date_prestation;

  Booking(
      {this.uid_book,
      this.uid_user,
      this.uid_dj,
      this.commentaire,
      this.accept,
      this.date_prestation});

  Booking.fromJson(Map<String, dynamic> json) {
    uid_book = json["uid_book"];
    uid_user = json["uid_user"];
    uid_dj = json["uid_dj"];
    commentaire = json["commentaire"];
    accept = json["accept"];
    date_prestation = json["date_prestation"];
  }

  Map<String, dynamic> toJson() {
    return {
      "uid_book": uid_book,
      "uid_user": uid_user,
      "uid_dj": uid_dj,
      "commentaire": commentaire,
      "accept": accept,
      "date_prestation": date_prestation,
    };
  }
}
