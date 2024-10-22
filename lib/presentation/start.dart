// home_page.dart
import 'package:craft_it/presentation/login_screen.dart';
import 'package:craft_it/presentation/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/theme/app_colors.dart';

class StartScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                // here we will add the Logo
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.15, top: screenHeight * 0.02),
                        child: Text(
                          'CarftIt',
                          style: TextStyle(
                            fontFamily: 'Kathen',
                            fontSize: screenWidth * 0.06, // Responsive font size
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkText
                                : AppColors.lightText,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.15),
                        child: SvgPicture.asset(
                          'assets/images/logo.svg',
                          width: screenWidth * 0.75, // Responsive image size
                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 10),
                Text(
                  'انشاء حساب',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.yellow,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'صاحب متجر',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.yellow,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'مشتري',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'أو',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.white
                        : AppColors.black, // Text color
                    backgroundColor: Colors.transparent, // Transparent background for OutlinedButton
                    side: BorderSide(color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.white
                        : AppColors.black, width: 1), // Outline color and width
                    padding: EdgeInsets.symmetric(vertical: 10.0), // Padding for button height
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'تسجيل دخول',  // Arabic text for "Customer"
                      style: TextStyle(
                        fontSize: 16,         // Font size of the text
                        color: Colors.black,   // Color of the text
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}

