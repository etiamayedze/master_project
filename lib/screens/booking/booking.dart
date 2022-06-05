import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:master_project/services/auth_service.dart';
import 'package:master_project/services/dbservice.dart';

import '../../utils/utils.dart';

class Booking extends StatefulWidget {
  final String uid_dj;
  const Booking({Key? key, required this.uid_dj}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController comment = TextEditingController();




  final _formKey = GlobalKey<FormState>();
  //final format = DateFormat('yyyy-MM-dd HH:mm');

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
            Text('Booking ',
                style: GoogleFonts.mochiyPopOne(
                  color: CupertinoColors.black,
                  fontSize: 25,
                )),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: Lottie.asset(
                      "assets/calendar.json",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    child: Center(
                      child: TextField(
                        controller:
                            dateinput, //editing controller of this TextField
                        decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Choisir une date", //label text of field
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              dateinput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    child: Center(
                      child: TextField(
                        controller:
                            timeinput, //editing controller of this TextField
                        decoration: InputDecoration(
                          icon: Icon(Icons.timer), //icon of text field
                          labelText: "Choisir une heure", //label text of field
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              timeinput.text =
                                  formattedTime; //set the value of text field.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                        padding: const EdgeInsets.all(10.0),
                        height: 100,
                        child: Center(
                          child: TextFormField(
                            controller: comment,
                            decoration: InputDecoration(
                                icon: Icon(Icons.comment),
                                labelText: "Commentaire",
                                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ),
                  SizedBox(
                    height: 50,
                  ),
              Container(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue.shade700,
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: ()  {
                        print(widget.uid_dj);
                        print(AuthServices().user?.uid);
                        addToBook(AuthServices().user!.uid, widget.uid_dj, comment.text, true, dateinput.text, timeinput.text );
                        dateinput.clear();
                        timeinput.clear();
                        comment.clear();
                        Fluttertoast.showToast(msg: "Vous avez bien booké ce DJ");
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Booker",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addToBook(String? uid_user, String? uid_dj, String? commentaire, bool? accept, String? date_prestation, String? heure_presation)async{
    setState((){
      _isLoading = true;
    });
    try{
      String res = await DbServices().book(
        AuthServices().user!.uid,
        widget.uid_dj,
        comment.text,
        accept = true,
        dateinput.text,
        timeinput.text,
      );
      if(res == "success"){
        setState((){
          _isLoading = false;
        });
        showSnacBar(context,'Booked!');
      }else{
        setState((){
          _isLoading = false;
        });
        showSnacBar(context, res);
      }
    }catch(err){
      showSnacBar(context,err.toString());
    }

  }
}
