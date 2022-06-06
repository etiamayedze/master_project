import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_project/providers/firestore_methods.dart';
import 'package:master_project/providers/get_user.dart';

import '../../data/models/user_model.dart';

class EditUserProfile extends StatefulWidget {
  final userDetail;
  const EditUserProfile({Key? key, required this.userDetail}) : super(key: key);

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPrenomController = TextEditingController();
  TextEditingController userUsernamController = TextEditingController();
  TextEditingController userBioController = TextEditingController();
  TextEditingController userPaysController = TextEditingController();
  TextEditingController userVilleController = TextEditingController();
  TextEditingController userImageController = TextEditingController();
  TextEditingController userFactureController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    userNameController.text = "${widget.userDetail['nom']}";
    userPrenomController.text = "${widget.userDetail['prenom']}";
    userUsernamController.text = "${widget.userDetail['username']}";
    userBioController.text = "${widget.userDetail['bio']}";
    userPaysController.text = "${widget.userDetail['pays']}";
    userVilleController.text = "${widget.userDetail['ville']}";
    super.initState();
    _getActualUser();
  }

  User? user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;
  UserModel loginUser = UserModel();
  _getActualUser() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loginUser = UserModel.fromMap(value.data());
    });
  }

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
            Text('Modifier profil ',
                style: GoogleFonts.mochiyPopOne(
                  color: CupertinoColors.black,
                  fontSize: 25,
                )),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1)),
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.userDetail['imgUrl'],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            color: Colors.blue),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Fields to update
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: userPrenomController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    labelText: "Nom",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    labelText: "Prénom",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: userUsernamController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    labelText: "Nom d'utilisateur",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: userBioController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    labelText: "Biographie",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: userPaysController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    labelText: "Pays",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: userVilleController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    labelText: "Ville",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    labelText: "Nom",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    labelText: "Nom",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text("Annuler",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black)),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if(userNameController.text=="" || userPrenomController.text=="" || userUsernamController.text=="" || userBioController=="" || userPaysController=="" || userVilleController==""){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Les champs sont obligatoires!"),));
                      }else{
                        setState((){
                          isLoading = true;
                        });
                        await FirestoreMethods().updateUserData(widget.userDetail['uid'], userNameController.text, userPrenomController.text,userUsernamController.text,userBioController.text, userPaysController.text, userVilleController.text);
                        setState((){
                          isLoading = false;
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Enregistrer",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
