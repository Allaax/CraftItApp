import 'package:craft_it/widgets/themeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ThemeSwitchButton(),


        bottomNavigationBar: BottomNavigationBar(
          // currentIndex: widget.currentIndex,
          // onTap: (index) {
          //   setState(() => widget.currentIndex = index);
          //   _loadScreen();
          // },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          iconSize: 35,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              // fontFamily: GoogleFonts.almarai().fontFamily
          ),
          unselectedLabelStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.cyan,
              // fontFamily: GoogleFonts.almarai().fontFamily
          ),
          // backgroundColor: Colors.cyan,
          // unselectedItemColor: Colors.cyan,
          // selectedItemColor: Colors.cyan,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'المتاجر',
              icon: Icon(
                Icons.storefront_outlined,
              ),
            ),
            BottomNavigationBarItem(
              label: 'الرئيسية',
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              label: 'حسابي',
              icon: Icon(Icons.account_circle_sharp),
            ),

          ],
        ),


      ),
    );
  }
}
