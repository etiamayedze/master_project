import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../data/models/user_model.dart';
import '../../widgets/user_profile_stat.dart';
import '../signup/login.dart';

class UserProfile extends StatefulWidget {

  //
  final String uid;
  //
  const UserProfile({Key? key, required this.uid}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  //
  var userData = {};
  //

  //
  @override
  void initState(){
    super.initState();
    getUserData();
  }

  getUserData() async{
    try{
    var ds = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
     userData = ds.data()!;
     setState(() {

     });

    }catch(e){
      print(e);
    }
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${userData['nom']} ${userData['prenom']}",
              textAlign: TextAlign.left,
              style: GoogleFonts.mochiyPopOne(
                color: CupertinoColors.black,
                fontSize: 20,
              )),
          backgroundColor: Colors.white,
          actions: [
            PopupMenuButton(
                icon: Icon(Icons.more_horiz_outlined,
                  color: Colors.black,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Deconnexion"),
                    onTap: () => Deconnexion(context),
                    value: 1,
                  ),

                  /*PopupMenuItem(
                    child: Text("Second"),
                    value: 2,
                  )*/

                ]
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  userData['imgUrl'],
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                "${userData['nom']} ${userData['prenom']}",
                style: GoogleFonts.mochiyPopOne(
                  color: CupertinoColors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                "@username",
                style: GoogleFonts.mochiyPopOne(
                  color: CupertinoColors.secondaryLabel,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  userProfileStat("Publictions", "7"),
                  userProfileStat("Abonnés", "7"),
                  userProfileStat("Abonnement", "7"),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () {},
                    color: Colors.black,
                    child: Text(
                      "Follow",
                      style: GoogleFonts.mochiyPopOne(
                        color: CupertinoColors.white,
                        fontSize: 12,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlineButton(
                    onPressed: () {},
                    color: Colors.white38,
                    child: Text(
                      "Message",
                      style: GoogleFonts.mochiyPopOne(
                        color: CupertinoColors.black,
                        fontSize: 15,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 8.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  FlatButton(
                    onPressed: () {},
                    color: Colors.black,
                    child: Text(
                      "Devis",
                      style: GoogleFonts.mochiyPopOne(
                        color: CupertinoColors.white,
                        fontSize: 12,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 18.0,
                  thickness: 0.6,
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ));
  }

  Column customedColumn(String label, [int? num]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num.toString(),
          style: GoogleFonts.mochiyPopOne(
            color: CupertinoColors.black,
            fontSize: 15,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.mochiyPopOne(
            color: CupertinoColors.black,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Future<void> Deconnexion(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }

}
