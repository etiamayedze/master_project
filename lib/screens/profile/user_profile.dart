import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master_project/data/models/user_model.dart';
import 'package:master_project/screens/booking/booking.dart';
import 'package:master_project/screens/booking/mesReservations.dart';
import 'package:master_project/screens/profile/editUserProfile.dart';
import 'package:path_provider/path_provider.dart';
import '../../widgets/customedButton.dart';
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

      UserModel user;

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
          backgroundColor: Colors.grey,
          actions: [
            PopupMenuButton(
                icon: Icon(
                  Icons.more_horiz_outlined,
                  color: Colors.black,
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Réservations"),
                        onTap: (){MesReservations();},
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text("Deconnexion"),
                        onTap: () => Deconnexion(context),
                        value: 1,
                      ),
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
                height: 10.0,
              ),
              FirebaseAuth.instance.currentUser!.uid != widget.uid
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 2.0,
                        ),

                        //Bouton pour le booking
                        CustomedButton(
                            longueur: 100,
                            hauteur: 35,
                            label: "Booker",
                            function: () {
                              var snapshot = FirebaseFirestore.instance
                                  .collection('users')
                                  .where('uid', isEqualTo: userData["uid"])
                                  .snapshots();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Booking(
                                    uid_dj: (userData['uid'] as dynamic),
                                  ),
                                ),
                              );
                            }),
                        SizedBox(
                          width: 2.0,
                        ),

                        //Boutton pour télécharger un devis
                        CustomedButton(
                            longueur: 100,
                            hauteur: 35,
                            label: "Devis",
                            function: () {
                              downloadFile();
                            }),
                        SizedBox(
                          width: 2.0,
                        ),

                        // Boutton pour envoyer un message
                        CustomedButton(
                            longueur: 100,
                            hauteur: 35,
                            label: "Message",
                            function: () {}),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 2.0,
                        ),
                        CustomedButton(
                            longueur: 200,
                            hauteur: 35,
                            label: "Modifier profil",
                            function: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditUserProfile()),
                              );
                            }),
                      ],
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 4.0,
                  thickness: 0.3,
                ),
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          DocumentSnapshot snap =
                              (snapshot.data! as dynamic).docs[index];
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

  /* String getFileName(String url) {
    RegExp regExp = new RegExp(r'.+(\/|%2F)(.+)\?.+');
    //This Regex won't work if you remove ?alt...token
    var matches = regExp.allMatches(url);

    var match = matches.elementAt(0);
    print("${Uri.decodeFull(match.group(2)!)}");
    return Uri.decodeFull(match.group(2)!);
  }*/

  Future<void> downloadFile() async {
    final httpsReference =
        FirebaseStorage.instance.refFromURL("${userData['facture']}");
    final appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('/storage/emulated/0/Download/devis.pdf');
    print(downloadToFile);
    final downloadTask = httpsReference.writeToFile(downloadToFile);
    downloadTask.snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          // TODO: Handle this case.
          print("running");
          break;
        case TaskState.paused:
          // TODO: Handle this case.
          print("paused");
          Fluttertoast.showToast(msg: "Téléchargement en pause");
          break;
        case TaskState.success:
          // TODO: Handle this case.
          print("sucess");
          Fluttertoast.showToast(
              msg:
                  "Téléchargement réussi. Le fichier se trouve dans /storage/emulated/0/Download/ ");
          break;
        case TaskState.canceled:
          // TODO: Handle this case.
          print("canceled");
          Fluttertoast.showToast(msg: "Téléchargement annulé");
          break;
        case TaskState.error:
          // TODO: Handle this case.
          print("error");
          Fluttertoast.showToast(
              msg: "Une erreur est survenue lors du téléchargement");
          break;
      }
    });
  }
}
