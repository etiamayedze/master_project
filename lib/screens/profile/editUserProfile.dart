
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:master_project/providers/firestore_methods.dart';
import '../../data/models/user_model.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

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
  TextEditingController userDemoLinkController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    userNameController.text = "${widget.userDetail['nom']}";
    userPrenomController.text = "${widget.userDetail['prenom']}";
    userUsernamController.text = "${widget.userDetail['username']}";
    userBioController.text = "${widget.userDetail['bio']}";
    userPaysController.text = "${widget.userDetail['pays']}";
    userVilleController.text = "${widget.userDetail['ville']}";
    userDemoLinkController.text = "${widget.userDetail['demoLink']}";
    super.initState();
    _getActualUser();
  }

  User? user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;
  UserModel loginUser = UserModel();
  _getActualUser() async {
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
                style: TextStyle(
                  color: CupertinoColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
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
                    ClipOval(
                        child: Material(
                            color: Colors.transparent,
                            child: Ink.image(
                              image: widget.userDetail['imgUrl'] != ""
                                  ? NetworkImage(
                                      "${widget.userDetail['imgUrl']}")
                                  : NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png"),
                              fit: BoxFit.cover,
                              width: 128,
                              height: 128,
                              child: InkWell(onTap: () {
                                _upload('gallery');
                              }),
                            ))),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: ClipOval(
                        child: Container(
                            padding: EdgeInsets.all(4),
                            color: Colors.white,
                            child: ClipOval(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                color: Colors.blue,
                                child: Icon(
                                  loginUser.imgUrl == ""
                                      ? Icons.add_a_photo
                                      : Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            )),
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
                  controller: userDemoLinkController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    labelText: "Lien vers démo",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 2.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _uploadPdf();
                    },
                    child: Text("Uploader un Devis",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white)),
                  ),
                ],
              ),

              SizedBox(height: 20),

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
                      if (userNameController.text == "" ||
                          userPrenomController.text == "" ||
                          userUsernamController.text == "" ||
                          userBioController == "" ||
                          userPaysController == "" ||
                          userVilleController == "" ||
                          userDemoLinkController == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Les champs sont obligatoires!"),
                        ));
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        await FirestoreMethods().updateUserData(
                            widget.userDetail['uid'],
                            userNameController.text,
                            userPrenomController.text,
                            userUsernamController.text,
                            userBioController.text,
                            userPaysController.text,
                            userVilleController.text,
                            userDemoLinkController.text);
                        setState(() {
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

  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;

    pickedImage =
        await picker.pickImage(source: ImageSource.gallery, maxWidth: 1920);

    final String fileName =
        "img_profile_${widget.userDetail['uid']}_${Timestamp.now().seconds}.jpg";
    File imageFile = File(pickedImage!.path);
    setState(() {
      isLoading = true;
    });
    // Uploading the selected image with some custom meta data
    TaskSnapshot snapshot = await storage.ref(fileName).putFile(
        imageFile,
        SettableMetadata(customMetadata: {
          'uploaded_by': '${widget.userDetail['uid']}',
          'description': 'Image de profile User ${widget.userDetail['uid']}'
        }));
    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userDetail['uid'])
          .update({"imgUrl": downloadUrl});
      _getActualUser();
    }
    // Refresh the UI
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _uploadPdf() async {
    //pick pdf file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pdfFile = File(result!.files.single.path.toString());
    //var file = pick.readAsBytesSync();
    String name = "Devis_${widget.userDetail['uid']}_${Timestamp.now().seconds}.pdf";
    setState(() {
      isLoading = true;
    });
    // upload file
    //var pdfFile = FirebaseStorage.instance.ref().child(name).child(("/.pdf"));

    TaskSnapshot snapshot = await storage.ref(name).putFile(
        pdfFile,
        SettableMetadata(customMetadata: {
          'uploaded_by': '${widget.userDetail['uid']}',
          'description': 'Image de profile User ${widget.userDetail['uid']}'
        }
    ));
    if(snapshot.state == TaskState.success){
      final String url = await snapshot.ref.getDownloadURL();
      //upload url to cloud firebase
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userDetail['uid'])
          .update({"facture":url});
      _getActualUser();
    }
    //refresh the ui
    setState(() {
      isLoading = false;
    });
  }
}
