import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_project/screens/booking/booking.dart';
import 'package:master_project/services/auth_service.dart';
import 'package:master_project/services/dbservice.dart';

import '../../data/models/booking_model.dart';

class MesReservations extends StatefulWidget {
  const MesReservations({Key? key}) : super(key: key);

  @override
  State<MesReservations> createState() => _MesReservationsState();
}

class _MesReservationsState extends State<MesReservations> {
  var userData = {};
  int bookLenght = 0;

  /* getUserData() async {
    try {
      var usersnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(AuthServices().user?.uid)
          .get();


      var booksnap = await FirebaseFirestore.instance
          .collection('booking')
          .where('uid_user', isEqualTo: AuthServices().user?.uid)
          .get();
      bookLenght = booksnap.docs.length;
      userData = usersnap.data()!;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Mes Reservations',
                style: GoogleFonts.mochiyPopOne(
                  color: CupertinoColors.black,
                  fontSize: 25,
                )),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('booking')
            .where('uid_dj', isEqualTo: AuthServices().user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData) {
            return Center(child: (CircularProgressIndicator()));
          }

          QuerySnapshot data = snapshot.requireData as QuerySnapshot;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              Map item = data.docs[index].data() as Map;
              return SizedBox(
                width: 150,
                height: 175,
                child: Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  shadowColor: Colors.blueGrey,
                  elevation: 10,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(item['commentaire'],
                            style: GoogleFonts.mochiyPopOne(
                              color: CupertinoColors.black,
                              fontSize: 15,
                            )),
                        subtitle: Text(
                            "${item['date_prestation']}   ${item['heure_prestation']}",
                            style: GoogleFonts.mochiyPopOne(
                              color: CupertinoColors.systemGrey,
                              fontSize: 12,
                            )),
                        leading: Icon(Icons.book),
                      ),
                      item['accept'] == 1
                          ? Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'En attente de validation',
                                        style: GoogleFonts.mochiyPopOne(
                                          color: CupertinoColors.activeBlue,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            print('Accepté');
                                            print(item);
                                            final docBooking = FirebaseFirestore.instance.collection('booking').doc(item['book_id']);
                                            docBooking.update({
                                              'accept': 2
                                            });
                                          },
                                          style: TextButton.styleFrom(
                                            primary: Colors.green,
                                          ),
                                          child: Text('Accepter')),
                                      TextButton(
                                          onPressed: () {
                                            print('Refusé');
                                            print(item);
                                            final docBooking = FirebaseFirestore.instance.collection('booking').doc(item['book_id']);
                                            docBooking.update({
                                              'accept': 3
                                            });
                                          },
                                          style: TextButton.styleFrom(
                                            primary: Colors.redAccent,
                                          ),
                                          child: Text('Refuser')),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : item['accept'] == 2
                              ? Container(
                                  child: Text(
                                    'Validé',
                                    style: GoogleFonts.mochiyPopOne(
                                      color: CupertinoColors.activeGreen,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              : Container(
                                  child: Text(
                                    'Refusé',
                                    style: GoogleFonts.mochiyPopOne(
                                      color: CupertinoColors.destructiveRed,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
