import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:master_project/screens/authentication/authentication.dart';
import 'package:master_project/screens/global/navigation.dart';
import 'package:master_project/screens/profile/profile.dart';
import 'package:master_project/screens/signup/login.dart';
import 'package:master_project/screens/signup/signup.dart';

import 'screens/global/loading.dart';


const String FAVORITES_BOX = "favorites";
const String CONNECTION_BOX = "connection";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(FAVORITES_BOX);
  await Hive.openBox(CONNECTION_BOX);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final box = Hive.box(CONNECTION_BOX);
  bool init = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        await box.put("isLoggin", false);
      } else {
        await box.put("isLoggin", true);
        await box.put("uid", user.uid);
      }
    });
    setState(() {
      init = true;
    });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (!init) return Loading();
    if (Hive.box("connection").get("isLoggin")) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Navigation(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Profil(),
      );
    }
  }
}
