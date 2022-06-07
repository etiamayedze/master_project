import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CardComment extends StatefulWidget {
  final snap;
  const CardComment({Key? key, required this.snap,}) : super(key: key);

  @override
  State<CardComment> createState() => _CardCommentState();
}

class _CardCommentState extends State<CardComment> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18, horizontal: 16,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              widget.snap['profilePic'],
            ),
            radius: 18,
          ),
          Expanded(
            child: Padding(padding: const EdgeInsets.only(left: 16,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.snap['name'],
                          style: const TextStyle(
                            color: Colors.black,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '  ${widget.snap['text']}',
                          style: const TextStyle(
                            color: Colors.black,
                            ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        widget.snap['datePubliched'].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        //fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.favorite, size: 16,),
          ),
        ],
      ),
    );
  }
}
