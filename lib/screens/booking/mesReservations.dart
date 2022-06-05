import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MesReservations extends StatefulWidget {
  const MesReservations({Key? key}) : super(key: key);

  @override
  State<MesReservations> createState() => _MesReservationsState();
}

class _MesReservationsState extends State<MesReservations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Booking ',
                style: GoogleFonts.mochiyPopOne(
                  color: CupertinoColors.black,
                  fontSize: 25,
                )),
          ],
        ),
      ),
    );
  }
}
