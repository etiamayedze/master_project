import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_project/data/models/user_model.dart';
import 'package:master_project/screens/chat/chatList.dart';

class ChatDiscussion extends StatelessWidget {
  const ChatDiscussion({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.nom!,
            style: GoogleFonts.mochiyPopOne(
              color: CupertinoColors.black,
              fontSize: 20,
            )),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatList()),
            );
          } ,
        ) ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: ListView(
              children: [

              ],
            ),),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.send)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
