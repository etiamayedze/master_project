import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_project/data/models/user_model.dart';
import 'package:master_project/screens/authentication/dbservice.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussions ',
            style: GoogleFonts.mochiyPopOne(
              color: CupertinoColors.black,
              fontSize: 25,
            )),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            Navigator.pop(context);
          } ,
        ) ,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: DbServices().getDiscussionUser,
        builder: (_,s){
          if(s.hasData){
            final users = s.data;
            return ListView.builder(itemBuilder: (ctx, i){
              final user = users![i];
              print(user.nom);
              return ListTile(
                title: Text(user.nom!),
                subtitle: Text(user.email!),
              );
            });
          }else{
            return Center(
              child: CircularProgressIndicator()
            );
          }
        },
      ),
    );
  }
}
