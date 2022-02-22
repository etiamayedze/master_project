import 'package:flutter/material.dart';
import 'package:master_project/screens/authentication/authentication.dart';
import 'package:lottie/lottie.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/play-dvd-disk.json', height: 300),
              Text('DJBOOK',
                  style: TextStyle(
                      fontSize: 30,
                      color: const Color(0xff37718E),
                      fontWeight: FontWeight.bold)),
            ],
          )
      ),
    );
  }
}