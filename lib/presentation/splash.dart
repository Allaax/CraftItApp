// splash_screen.dart
import 'package:craft_it/presentation/login_screen.dart';
import 'package:craft_it/presentation/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay of 3 seconds and navigate to HomePage
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartScreen()),
      );
    });
  }

  @override
  /*Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Splash screen image
            Image.asset(
              'assets/images/loving.png', // Update with the correct path
              height: 250,
            ),
            SizedBox(height: 20),
            SvgPicture.asset(
              'assets/images/logo.svg',
              width:50, // Responsive image size
            ),
            // "CraftIt" Text
            Text(
              'CraftIt',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            // Arabic subtitle
            Text(
              'مصنوع بكل حب',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Splash screen image
            SvgPicture.asset(
              'assets/images/human.svg', // Ensure the path is correct
              height: 250,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                // SVG Image with fixed right padding
                Padding(
                  padding: EdgeInsets.only(right: 115.0), // Fixed right padding
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 350.0, // Fixed width for the SVG
                  ),
                ),
                // Text overlay with fixed padding
                Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 10.0), // Fixed left and top padding
                  child: Text(
                    'CraftIt',
                    style: TextStyle(
                      fontFamily: 'Kathen',
                      fontSize: 34.0, // Fixed font size
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 90), // Fixed left and top padding
                  child: Text(
                    'مصنوع بكل حب',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),

              ],
            ),
            // Arabic subtitle

          ],
        ),
      ),
    );
  }
}
