import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:master_project/providers/user_Provider.dart';
import 'package:master_project/screens/profile/components/profile_menu.dart';
import 'package:master_project/data/models/user_model.dart';
import 'package:master_project/screens/widgets/likes.dart';
import 'package:master_project/screens/comment/comments.dart';
import 'package:master_project/utils/utils.dart';
import 'package:master_project/providers/firestore_methods.dart';



class FeedCard extends StatefulWidget {
  final snap;

  const FeedCard({Key? key, required this.snap,}) : super(key: key);

  @override
  State<FeedCard> createState() => _FeedCardState();
}
const webScreenSize = 600;
class _FeedCardState extends State<FeedCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }
  void getComments() async {
    try{
      QuerySnapshot snap =  await FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').get();
      commentLen = snap.docs.length;
    }catch(err){
      showSnacBar(context, err.toString());
    }
    setState(() {});

  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnacBar(
        context,
        err.toString(),
      );
    }
    setState(() {});
  }

  deletePost(String postId) async {
    try {
      await FirestoreMethods().deletePost(postId);
    } catch (err) {
      showSnacBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    // final width = MediaQuery
    //     .of(context)
    //     .size
    //     .width;
    return Container(
      // boundary needed for web
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
      //   ),
      //   color: mobileBackgroundColor,
      // ),
      padding: const EdgeInsets.symmetric(
          vertical: 10
      ),
      child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16
              ).copyWith(right: 0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(

                      widget.snap['profImage'].toString(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.snap['username'].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.snap['uid'].toString() == user.uid
                      ? IconButton(
                    onPressed: () {
                      showDialog(
                        useRootNavigator: false,
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ListView(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16),
                                shrinkWrap: true,
                                children: [
                                  'Delete',
                                ]
                                    .map(
                                      (e) =>
                                      InkWell(
                                          child: Container(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 12,
                                                horizontal: 16),
                                            child: Text(e),
                                          ),
                                          onTap: () {
                                            deletePost(
                                              widget.snap['postId']
                                                  .toString(),
                                            );
                                            // remove the dialog box
                                            Navigator.of(context).pop();
                                          }),
                                )
                                    .toList()),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.more_vert),
                  )
                      : Container(),
                ],
              ),
            ),

            //IMAGE SECTION
            GestureDetector(
              onDoubleTap: () {
                FirestoreMethods().likePost(
                  widget.snap['postId'].toString(),
                  user.uid,
                  widget.snap['likes'],
                );
                setState(() {
                  isLikeAnimating = true;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: Image.network(
                      widget.snap['postUrl'].toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isLikeAnimating ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: isLikeAnimating,
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 100,
                      ),
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            //LIKE COMMENT SECTION
            Row(
              children: <Widget>[
                LikeAnimation(
                  isAnimating: widget.snap['likes'].contains(user.uid),
                  smallLike: true,
                  child: IconButton(
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                        : const Icon(
                      Icons.favorite_border,
                    ),
                    onPressed: () => FirestoreMethods().likePost(
                      widget.snap['postId'].toString(),
                      user.uid,
                      widget.snap['likes'],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.comment_outlined,
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Comment(
                        snap: widget.snap['postId'].toString(),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    icon: const Icon(
                      Icons.send,
                    ),
                    onPressed: () {}),
                Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          icon: const Icon(Icons.bookmark_border), onPressed: () {}),
                    ))
              ],
            ),

            // DESCRIPTION AND NUMBER OF COMMENTS
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.w800),
                      child: Text(
                        '${widget.snap['likes'].length} likes',
                        style: Theme.of(context).textTheme.bodyText2,
                      )),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: primaryColor),
                        children: [
                          TextSpan(
                            text: widget.snap['username'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' ${widget.snap['description']}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      child: Text(
                        'View all $commentLen comments',
                        style: const TextStyle(
                          fontSize: 16,
                          color: secondaryColor,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Comment(
                          snap: widget.snap['postId'].toString(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePubliched'].toDate()),
                      style: const TextStyle(
                        color: secondaryColor,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                  ),

                ],
              ),
            ),
          ]
      ),
    );
  }
}



