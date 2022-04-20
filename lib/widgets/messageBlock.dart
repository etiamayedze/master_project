import 'package:flutter/material.dart';

import '../data/models/message_model.dart';

class MessageBlock extends StatelessWidget {
  const MessageBlock({Key? key, this.msg}) : super(key: key);
  final Message? msg;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: msg!.itsMe?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: msg!.itsMe?Radius.circular(10):Radius.circular(0),
              bottomRight: msg!.itsMe?Radius.circular(0):Radius.circular(10),
            ),
          ),
          constraints: BoxConstraints(
            minWidth: 30,
            minHeight: 40,
            maxWidth: screenWidth/1.1,
          ),
          child: Text(msg!.contenu!),
        ),
      ],
    );
  }
}
