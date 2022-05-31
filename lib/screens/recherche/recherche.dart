import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Recherche extends StatefulWidget {
  const Recherche({Key? key}) : super(key: key);

  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  final TextEditingController rechercheController = TextEditingController();
  bool montreUser = false;
  @override
  void dispose(){
    super.dispose();
    rechercheController.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: rechercheController,
          decoration: InputDecoration(
            labelText: 'Recherche',

          ),
          onFieldSubmitted: (String _){
            setState(() {
              montreUser = true;
            });;
          },
        ),
      ),
      body: montreUser? StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').where('nom', isGreaterThanOrEqualTo: rechercheController.text).snapshots(),
          builder: (context, snapshot){
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        (snapshot.data! as dynamic).docs[index]['imgUrl'],
                    ),
                  ),
                  title: Text((snapshot.data! as dynamic).docs[index]['nom'],
                      style: GoogleFonts.mochiyPopOne(
                        color: CupertinoColors.black,
                        fontSize: 20,
                      )
                  ),
                );
              }
              );
        },
      ): Text("No Users"),
    );
  }
}
