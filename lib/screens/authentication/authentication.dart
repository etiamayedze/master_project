import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Lottie.asset('assets/dj-mixer.json', height: 200, width: 500),
            const Text("Login",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 44.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 44.0,
            ),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "User Email",
                prefixIcon: Icon(Icons.mail, color: Colors.black,),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.lock, color: Colors.black,),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text("Password oublié?",
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(
              height: 88.0,
            ),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                onPressed: () {},
                child: const Text("Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],

        ),
      ),
    );

  }
}