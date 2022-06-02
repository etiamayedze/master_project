import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  int postLenght = 0;
  //

  //
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    try {
      var usersnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      var postsnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLenght = postsnap.docs.length;
      userData = usersnap.data()!;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
  //

  @override
  Widget build(BuildContext context) {
    if (userData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
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
                icon: Icon(
                  Icons.more_horiz_outlined,
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
                    ])
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Text(
                        "${userData['username']}",
                        style: GoogleFonts.mochiyPopOne(
                          color: CupertinoColors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    children: [
                      Text(
                        "${userData['ville']} ${userData['pays']}",
                        style: GoogleFonts.mochiyPopOne(
                          color: CupertinoColors.secondaryLabel,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${userData['bio']}",
                    style: GoogleFonts.mochiyPopOne(
                      color: CupertinoColors.secondaryLabel,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                child: Container(
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: widget.uid).get(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5, childAspectRatio: 1,),
                          itemBuilder: (context, index){
                          DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                          return Container(
                            child: Image(
                              image: NetworkImage(snap['postUrl']),
                              fit: BoxFit.cover,
                            ),
                          );
                      },
                      );
                    },

                  ),
                  ),
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
