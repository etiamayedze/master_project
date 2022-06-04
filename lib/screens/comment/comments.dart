import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:master_project/providers/firestore_methods.dart';
import 'package:master_project/screens/profile/components/profile_menu.dart';
import 'package:master_project/screens/widgets/comment_card.dart';
import 'package:master_project/data/models/user_model.dart';
import 'package:master_project/utils/utils.dart';
import 'package:provider/provider.dart';


import '../../providers/user_Provider.dart';
class Comment extends StatefulWidget {
  final postId;
  const Comment({Key? key, required this.postId}) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final TextEditingController _commentEditController = TextEditingController();

  void postComment(String? uid, String? name, String profilePic) async {
    try{
      String res = await FirestoreMethods().postComment(
          widget.postId,
          _commentEditController.text,
          uid,
          name,
          profilePic);
      if (res != 'success'){
        showSnacBar(context, res);
      }
      setState((){
        _commentEditController.text = "";
      });
    }catch(err){
      showSnacBar(context, err.toString(),
      );
    }
  }

  // @override
  // void dispose(){
  //   super.dispose();
  //   _commentEditController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .collection('comments')
            .orderBy(
          'datePubliched',
          descending: true,
        )
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => CardComment(
              snap: snapshot.data!.docs[index],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
          CircleAvatar(
          backgroundImage: NetworkImage(
          user.imgUrl,
          ),
          radius: 18,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 8.0),
            child: TextField(
              controller: _commentEditController,
              decoration: InputDecoration(
                hintText: 'Comment as ${user.nom}',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => postComment(
              user.uid,
              user.nom,
              user.imgUrl
          ),
          child: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: const Text(
                'Post',
                style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
      ],
    ),
    ),
    ),
    );
  }
}
