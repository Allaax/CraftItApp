import 'package:craft_it/widgets/themeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit/auth_cubit.dart';
import '../../../widgets/listTileForProfile.dart';

class ProfileScreen extends StatelessWidget {
  final String? profileImageUrl;

  const ProfileScreen({Key? key, this.profileImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              CircleAvatar(
                radius: screenWidth * 0.12, // You can adjust the size here
                backgroundImage:
                    profileImageUrl != null && profileImageUrl!.isNotEmpty
                        ? NetworkImage(profileImageUrl!) // Load image from URL
                        : null, // No child if image is available
                backgroundColor: Colors.grey, // Placeholder if no image
                child: profileImageUrl == null || profileImageUrl!.isEmpty
                    ? const Icon(Icons.person,
                        size: 50, color: Colors.white) // Default icon
                    : null, // Background color for placeholder
              ),
              ListTileForProfile(
                ontap: (){},

                title: 'الوضع الليلي',
                  leadingIcon: const ThemeSwitchButton(),
                  trailing: const Icon(Icons.dark_mode),

              ),ListTileForProfile(
                ontap: (){},

                title: 'تعديل الحساب',
                  leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded ,),
                  trailing: const Icon(Icons.account_circle_rounded),

              ),ListTileForProfile(
                ontap: (){},
                  title: 'عنواني' ,
                  leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded ,),
                  trailing: const Icon(Icons.location_on),

              ),ListTileForProfile(
                ontap: (){
                  context.read<AuthCubit>().logout();
                },

                title: 'تسجيل خروج',
                  leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded ,),
                  trailing: const Icon(Icons.logout_rounded),


              ),
            ],
          ),
        ),
      ),
    );
  }
}

