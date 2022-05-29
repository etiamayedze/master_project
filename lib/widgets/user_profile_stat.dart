import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget userProfileStat(String label1, String label2) {
  return Expanded(
    child: Column(
      children: [
        Text(
          label1,
          style: GoogleFonts.mochiyPopOne(
            color: CupertinoColors.secondaryLabel,
            fontSize: 12,
          ),
        ),
        Text(
          label2,
          style: GoogleFonts.mochiyPopOne(
            color: CupertinoColors.secondaryLabel,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
