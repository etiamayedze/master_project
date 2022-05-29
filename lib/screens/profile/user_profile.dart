import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/user_profile_stat.dart';

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                "username",
                style: GoogleFonts.mochiyPopOne(
                  color: CupertinoColors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                "@username",
                style: GoogleFonts.mochiyPopOne(
                  color: CupertinoColors.secondaryLabel,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  userProfileStat("Publictions", "7"),
                  userProfileStat("Abonnés", "7"),
                  userProfileStat("Abonnement", "7"),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () {},
                    color: Colors.black,
                    child: Text(
                      "Follow",
                      style: GoogleFonts.mochiyPopOne(
                        color: CupertinoColors.white,
                        fontSize: 12,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlineButton(
                    onPressed: () {},
                    color: Colors.white38,
                    child: Text(
                      "Message",
                      style: GoogleFonts.mochiyPopOne(
                        color: CupertinoColors.black,
                        fontSize: 15,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 8.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  FlatButton(
                    onPressed: () {},
                    color: Colors.black,
                    child: Text(
                      "Devis",
                      style: GoogleFonts.mochiyPopOne(
                        color: CupertinoColors.white,
                        fontSize: 12,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 18.0,
                  thickness: 0.6,
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ));
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
