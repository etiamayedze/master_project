import 'package:flutter/material.dart';

import '../../data/models/message_model.dart';

class MessageBlock extends StatelessWidget {
  const MessageBlock({Key? key, this.msg}) : super(key: key);
  final Messenger? msg;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment:
          msg!.itsMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              bottomRight:
                  msg!.itsMe ? Radius.circular(0) : Radius.circular(15),
              bottomLeft: msg!.itsMe ? Radius.circular(15) : Radius.circular(0),
            ),
            color:
                msg!.itsMe ? Colors.blueGrey : Colors.lightBlue.withOpacity(.7),
          ),
          padding: EdgeInsets.all(16),
          constraints: BoxConstraints(
            minWidth: 30,
            minHeight: 40,
            maxWidth: screenWidth / 1.1,
          ),
          child: Column(
            children: [
              Text(
                msg!.contenu!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                msg!.deliveryDate!.toDate().hour.toString() +
                    ":" +
                    msg!.deliveryDate!.toDate().minute.toString(),
                textAlign: msg!.itsMe ? TextAlign.end : TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
