import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master_project/data/models/message_model.dart';
import 'package:master_project/data/models/user_model.dart';
import 'package:master_project/services/auth_service.dart';
import 'package:uuid/uuid.dart';
import '../data/models/booking_model.dart';
import 'auth_service.dart';

class DbServices {
  var userCollection = FirebaseFirestore.instance.collection('users');
  var messageCollection = FirebaseFirestore.instance.collection('messages');
  var bookingCollection = FirebaseFirestore.instance.collection('booking');

  Stream<List<UserModel>> get getCurrentUser {
    return userCollection
        .where('uid', isEqualTo: AuthServices().user?.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => UserModel.fromMap(e.data())).toList());
  }

  Stream<List<UserModel>> get getDiscussionUser {
    return userCollection
        .where('uid', isNotEqualTo: AuthServices().user?.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => UserModel.fromMap(e.data())).toList());
  }

  Stream<List<BookingModel>> get getBookingUser {
    return bookingCollection
        .where('uid_dj', isEqualTo: AuthServices().user?.uid)
        .snapshots()
        .map((event) =>
        event.docs.map((e) => BookingModel.fromMap(e.data())).toList());
  }

  Stream<List<Message>> getMessage(String receiverID, [bool myMessage = true]) {
    return messageCollection
        .where('senderID',
            isEqualTo: myMessage ? AuthServices().user?.uid : receiverID)
        .where('receiverID',
            isEqualTo: myMessage ? receiverID : AuthServices().user?.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Message.fromJson(e.data(), e.id)).toList());
  }

  Future<bool> sendMessage(Message msg) async {
    try {
      await messageCollection.doc().set(msg.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> book(
    String uid_user,
    String uid_dj,
    String commentaire,
    int accept,
    String date_prestation,
    String heure_prestation,
  ) async {
    String res = "some error";
    print(res);
    try {
      //String postImage = await StorageMethods().uploadImageToStorage('posts', file, true) ;
      String book_id = const Uuid().v1();

      BookingModel book = BookingModel(
          book_id: book_id,
          uid_user: uid_user,
          uid_dj: uid_dj,
          commentaire: commentaire,
          accept: 1,
          date_prestation: date_prestation,
          heure_prestation: heure_prestation);
      FirebaseFirestore.instance.collection('booking').doc(book_id).set(
            book.toMap(),
          );
      res = "success";
      print(res);
    } catch (err) {
      res = err.toString();
      print(res);
    }
    return res;
  }

}
