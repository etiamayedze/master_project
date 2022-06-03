
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:master_project/providers/firestore_methods.dart';
import 'package:master_project/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../data/models/user_model.dart';
import '../../providers/user_Provider.dart';
import '../profile/components/profile_menu.dart';
class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  Uint8List? _file;
  bool _isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(
        title: const Text('Create a post'),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Take a photo'),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file = await pickImage(
                ImageSource.camera,
              );
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Choose from gallery '),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file = await pickImage(
                ImageSource.gallery ,
              );
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Cancel'),
            onPressed: () async{
              Navigator.of(context).pop();
            },
          ),

        ],
      );
    });
  }



  void postImage(String? uid,String? username, String profImage)async{
    setState((){
      _isLoading = true;
    });
    try{
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text,
          _file!,
          uid!,
        username!,
        profImage,
      );
      if(res == "success"){
        setState((){
          _isLoading = false;
        });
        showSnacBar(context,'Posted!');
        clearImage();
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

  void clearImage(){
    setState((){
      _file = null;
    });
  }

  @override
  void dispose(){
    super.dispose();
    _descriptionController.dispose();
  }

  // @override
  // void initState(){
  //   super.initState();
  //   _getActualUser();
  // }


  // User? user = FirebaseAuth.instance.currentUser ;
  // FirebaseStorage storage = FirebaseStorage.instance;
  // UserModel loginUser = UserModel();
  // _getActualUser() async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value){
  //     this.loginUser =UserModel.fromMap(value.data());
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
      child: IconButton(
        icon: const Icon(Icons.upload),
        onPressed: () => _selectImage(context),
      ),
    )
        :Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:clearImage,
        ),
        title: const Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () => postImage(
                  user.uid,
                  user.nom,
                  user.imgUrl
              ),
              child: const Text('post', style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),))
        ],

      ),
      body: Column(
        children: [
          _isLoading
              ? const LinearProgressIndicator()
              : const Padding(
            padding: EdgeInsets.only(top: 0),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    user.imgUrl
                ) ,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Ajouter une légende...',
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487/451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ],
      ),
    );

  }
}
