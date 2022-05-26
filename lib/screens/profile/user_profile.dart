import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Username',
            textAlign: TextAlign.left,
            style: GoogleFonts.mochiyPopOne(
              color: CupertinoColors.black,
              fontSize: 20,
            )),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.black12,
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          customedColumn("post", 10),
                          customedColumn("post", 10),
                          TextButton.icon(
                              label: Text(
                                'Book',
                                style: GoogleFonts.mochiyPopOne(
                                  color: CupertinoColors.black,
                                  fontSize: 15,
                                ),
                              ),
                              icon: Icon(Icons.book,
                              color: Colors.black,),
                              onPressed: () {
                                print('Pressed');
                              })
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextButton(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,

                          ),
                          alignment: Alignment.center,
                          child: Text('ok'),
                          height: 27,
                          width: 125,
                        ),
                        onPressed: (){},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column customedColumn(String label, [int? num]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num.toString(),
          style: GoogleFonts.mochiyPopOne(
            color: CupertinoColors.black,
            fontSize: 15,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.mochiyPopOne(
            color: CupertinoColors.black,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
