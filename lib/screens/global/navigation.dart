import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import '../accueil/accueil.dart';
import '../profile/profile.dart';
import '../favoris/favoris.dart';
import '../recherche/recherche.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _navigationState createState() => _navigationState();
}

class _navigationState extends State<Navigation> {
  Widget _accueil = Accueil();
  Widget _recherche = Recherche();
  Widget _favoris = Favoris();
  Widget _profil = Profil();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getBody() {
    if (_selectedIndex == 0){
      return this._accueil;
    }else if(_selectedIndex == 1){
      return this._recherche;
    }else if(_selectedIndex == 2){
      return this._favoris;
    }else {
      return this._profil;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Lottie.asset("assets/dj.json"),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('DJ ',
                style: GoogleFonts.mochiyPopOne(
                  color: CupertinoColors.black,
                  fontSize: 25,
                )),
            Text('Booking',
                style: GoogleFonts.mochiyPopOne(
                  color: Colors.blue,
                  fontSize: 25,
                ))
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.textsms,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: getBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Accueil',
            tooltip: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Rechercher',
            tooltip: 'Rechercher',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favoris',
            tooltip: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'Profil',
            tooltip: 'Profil',
            //backgroundColor: Colors.grey,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
      ),
    );
  }
}
