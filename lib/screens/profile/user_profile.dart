import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Username',
            textAlign: TextAlign.left,
            style: GoogleFonts.mochiyPopOne(
              color: CupertinoColors.black,
              fontSize: 20,
            )),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.black12,
              ),
            ],
          ),
      ],
    ),
          ),
        ],
      ),

    );
  }
}
