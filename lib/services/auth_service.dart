import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  final _auth = FirebaseAuth.instance;

  User? get user => FirebaseAuth.instance.currentUser;

  Stream <User?> get onChangedUser => _auth.authStateChanges();
}
