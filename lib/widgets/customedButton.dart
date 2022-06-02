import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomedButton extends StatelessWidget {
  final String? label;
  final Function()? function;
  final double? longueur;
  final double? hauteur;

  const CustomedButton({
    Key? key,
    this.longueur,
    this.hauteur,
    this.label,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            label!,
            style: GoogleFonts.mochiyPopOne(
              color: CupertinoColors.extraLightBackgroundGray,
              fontSize: 15,
            ),
          ),
          width: longueur,
          height: hauteur,
        ),
      ),
    );
  }
}
