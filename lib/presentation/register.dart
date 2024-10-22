import 'package:craft_it/presentation/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../core/theme/app_colors.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final formkey = GlobalKey<FormState>();
bool _isPasswordVisible = false;

class _RegisterState extends State<Register> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return  Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkBackground
              : AppColors.white,
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
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

                    Padding(
                      padding: EdgeInsets.symmetric(                      vertical: screenHeight * 0.03,
                          horizontal: screenWidth * 0.04),
                      child: Focus(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'لا يمكن أن يكون الحقل فارغ';
                            }
                          },
                          textInputAction: TextInputAction.next,
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.darkGrey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'اسم المستخدم',
                            labelStyle: TextStyle(
                              fontSize: screenWidth * 0.035, // Responsive font size
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                            prefixIcon: Icon(Icons.person, color: AppColors.darkGrey),
                            contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                          ),
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: Focus(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'لا يمكن أن يكون الحقل فارغ';
                            } else if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return null;
                            } else {
                              return 'البريد الإلكتروني غير صالح';
                            }
                          },
                          textInputAction: TextInputAction.next,
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.darkGrey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'البريد الإلكتروني',
                            labelStyle: TextStyle(
                              fontSize: screenWidth * 0.035, // Responsive font size
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                            prefixIcon: Icon(Icons.email, color: AppColors.darkGrey),
                            contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                          ),
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.03,
                      ),
                      child: Focus(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'لا يمكن أن يكون الحقل فارغ';
                            }
                          },
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.darkGrey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'كلمة المرور',
                            labelStyle: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                            prefixIcon: Icon(Icons.lock, color: AppColors.darkGrey),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.darkGrey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                          ),
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                      ),
                    ),

                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                           child: SizedBox(
                             width: double.infinity,
                             child: ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 elevation: 0,
                                 padding: EdgeInsets.symmetric(
                                     vertical: screenHeight * 0.015, horizontal: screenWidth * 0.04),
                                 backgroundColor: AppColors.primary,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                 ),
                               ),
                               onPressed: () {
                                 Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(builder: (context) => LoginScreen()),
                                 );
                               },
                               child: Text(
                                 'إنشاء حساب',
                                 style: TextStyle(fontSize: screenWidth * 0.04),
                               ),
                             ),
                           ),
                         ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                        horizontal: screenWidth * 0.04,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.darkGrey
                                  : AppColors.black,
                            ),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.015, horizontal: screenWidth * 0.04),
                            backgroundColor: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.cardsBackgroundDark
                                : AppColors.cardsBackgroundLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Register()),
                            );
                          },
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(fontSize: screenWidth * 0.04),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
