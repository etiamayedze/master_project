import 'package:flutter/material.dart';
import 'package:master_project/data/models/user_model.dart';

class ChatDiscussion extends StatelessWidget {
  const ChatDiscussion({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.nom!),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: Container(),),
          Row(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.send)),
            ],
          ),
        ],
      ),
    );
  }
}
