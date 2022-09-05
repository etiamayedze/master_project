import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:master_project/data/models/message_model.dart';
import 'package:master_project/data/models/user_model.dart';
import 'package:master_project/services/auth_service.dart';
import 'package:master_project/services/dbservice.dart';
import 'package:master_project/screens/widgets/messageBlock.dart';

// notifications lybrarie
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';



class ChatDiscussion extends StatefulWidget {
  const ChatDiscussion({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  State<ChatDiscussion> createState() => _ChatDiscussionState();
}

class _ChatDiscussionState extends State<ChatDiscussion> {
  var messageController = TextEditingController();

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String? mtoken = " ";

  @override
  void initState() {
    super.initState();
    requestPermission();
    loadFCM();
    listenFCM();
    getToken();
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
      'token' : token,
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
      });
      saveToken(token!);
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=AAAA1D52mcs:APA91bGRMTamrWQZww-EzhvcLFlRFN9il9zZiAXB75yJxiJZT0t6HL_5do-4MvUTGOI-z-ZB7N58G5CQsk-TfEkXyFsFLkAXxac1yRHq4bjl4Oa9yEWbXPIffBpKlksHVvnXpqfeLTkP',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user!.nom!,
            style: GoogleFonts.mochiyPopOne(
              color: CupertinoColors.black,
              fontSize: 20,
            )),
        backgroundColor: Colors.grey,
        /*leading: GestureDetector(
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
        ),*/
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Messenger>>(
                stream: DbServices().getMessage(
                  widget.user!.uid!,
                ),
                builder: (context, snapshot1) {
                  if (snapshot1.hasData) {
                    return StreamBuilder<List<Messenger>>(
                      stream: DbServices().getMessage(widget.user!.uid!, false),
                      builder: (context, snapshot2) {
                        if (snapshot2.hasData) {
                          var messages = [
                            ...snapshot1.data!,
                            ...snapshot2.data!
                          ];
                          messages.sort((msg1, msg2) =>
                              msg1.deliveryDate!.compareTo(msg2.deliveryDate!));
                          messages = messages.reversed.toList();
                          return messages.length == 0
                              ? Center(
                                  child: Lottie.asset('assets/messages.json'),
                                )
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: messages.length,
                                  itemBuilder: (context, index) {
                                    final msg = messages[index];
                                    return Container(
                                      child: MessageBlock(
                                        msg: msg,
                                      ),
                                      margin: EdgeInsets.only(bottom: 8),
                                    );
                                  },
                                );
                        } else
                          return Center(
                              child: Lottie.asset('assets/messages.json'));
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
                IconButton(
                    onPressed: () async {
                      var msg = Messenger(
                        contenu: messageController.text,
                        deliveryDate: Timestamp.now(),
                        receiverID: widget.user!.uid,
                        senderID: AuthServices().user!.uid,
                      );
                      messageController.clear();
                      await DbServices().sendMessage(msg);
                      String title = "Message";
                      String body = "Message envoyé" ;

                      DocumentSnapshot snap =
                      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();

                      var token = snap['token'];

                      sendPushMessage(body,title,token);
                    },
                    icon: Icon(Icons.send)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
