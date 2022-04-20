import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:master_project/data/models/message_model.dart';
import 'package:master_project/data/models/user_model.dart';
import 'package:master_project/screens/chat/chatList.dart';
import 'package:master_project/services/auth_service.dart';
import 'package:master_project/services/dbservice.dart';
import 'package:master_project/widgets/messageBlock.dart';

class ChatDiscussion extends StatefulWidget {
  const ChatDiscussion({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  State<ChatDiscussion> createState() => _ChatDiscussionState();
}

class _ChatDiscussionState extends State<ChatDiscussion> {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user!.nom!,
            style: GoogleFonts.mochiyPopOne(
              color: CupertinoColors.black,
              fontSize: 20,
            )),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatList()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: DbServices().getMessage(widget.user!.uid!, ),
                builder: (context, snapshot1) {
                  if (snapshot1.hasData) {
                    return StreamBuilder<List<Message>>(
                      stream: DbServices().getMessage(widget.user!.uid!, false ),
                      builder: (context, snapshot2) {
                        if (snapshot2.hasData) {
                          final messages = [
                            ...snapshot1.data!,
                            ...snapshot2.data!
                          ];
                          messages.sort((msg1, msg2) =>msg1.deliveryDate!.compareTo(msg2.deliveryDate!));
                          return messages.length == 0?Center(
                            child: Lottie.asset('assets/messages.json'),
                          ): ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final msg = messages[index];
                              return MessageBlock(
                                msg: msg,
                              );
                            },
                          );
                        } else
                          return Center(child: Lottie.asset('assets/messages.json'));
                      },
                    );
                  } else
                    return Center(child: Lottie.asset('assets/messages.json'));
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Ecrire un message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: () async {
                  var msg = Message(
                    contenu: messageController.text,
                    deliveryDate: Timestamp.now(),
                    receiverID: widget.user!.uid,
                    senderID: AuthServices().user!.uid,
                  );
                  messageController.clear();
                  await DbServices().sendMessage(msg);
                }, icon: Icon(Icons.send)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
