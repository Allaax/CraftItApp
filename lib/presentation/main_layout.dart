import 'package:craft_it/bloc/cubit/bottom_nav_bar_cubit.dart';
import 'package:craft_it/bloc/state/bottom_nav_bar_state.dart';
import 'package:craft_it/presentation/navigation_screens/home_screen.dart';
import 'package:craft_it/presentation/navigation_screens/profile_screen.dart';
import 'package:craft_it/presentation/navigation_screens/stores_screen.dart';
import 'package:craft_it/widgets/themeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
            builder: (context, state) {
              if (state.navbarItem == NavbarItem.home) {
                return HomeScreen();
              } else if (state.navbarItem == NavbarItem.stores) {
                return StoresScreen();
              } else if (state.navbarItem == NavbarItem.profile) {
                return ProfileScreen();
              }
              return Container();
            }),


        bottomNavigationBar: BlocBuilder<BottomNavBarCubit,BottomNavBarState>(
          builder: (context, state){
          return BottomNavigationBar(
            currentIndex: state.index,
            showUnselectedLabels: true,
            // currentIndex: widget.currentIndex,
            // onTap: (index) {
            //   setState(() => widget.currentIndex = index);
            //   _loadScreen();
            // },
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            iconSize: 28,
            selectedLabelStyle: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              // fontFamily: GoogleFonts.almarai().fontFamily
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 16.0,
              color: Colors.cyan,
              // fontFamily: GoogleFonts.almarai().fontFamily
            ),

            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: 'المتاجر',
                icon: Icon(
                  Icons.store_rounded,
                ),
              ),
              BottomNavigationBarItem(
                label: 'الرئيسية',
                icon: Icon(Icons.home_rounded),
              ),
              BottomNavigationBarItem(
                label: 'حسابي',
                icon: Icon(Icons.person_rounded),
              ),


            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<BottomNavBarCubit>(context)
                    .getNavBarItem(NavbarItem.home);
              } else if (index == 1) {
                BlocProvider.of<BottomNavBarCubit>(context)
                    .getNavBarItem(NavbarItem.stores);
              } else if (index == 2) {
                BlocProvider.of<BottomNavBarCubit>(context)
                    .getNavBarItem(NavbarItem.profile);
              }
            },
          );



          }
        )


      ),
    );
  }
}
