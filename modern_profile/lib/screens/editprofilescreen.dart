import 'package:flutter/material.dart';
import 'package:modern_profile/components/profile_image.dart';
import 'package:modern_profile/components/profile_menu.dart';
import 'package:modern_profile/constant/constant.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPostColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: bgPostColor,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const ProfileImage(),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Maltika Boomalert',
                style: textTitle,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "s6503051614046@kmutnb.ac.th",
                style: textSubTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 150,
                height: 30,
                decoration: BoxDecoration(
                  color: iconSkyColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: const Center(
                    child: Text(
                  'Edit Profile',
                  style:  TextStyle(color: textPrimaryColor),
                )),
              ),
                
              //profile menu
              const SizedBox(
                height: 30,
              ),
              const ProfileMenu(
                title: 'Setting',
                icons: Icons.settings,
              ),
              const SizedBox(
                height: 13,
              ),
              const ProfileMenu(title: 'Favorite', icons: Icons.favorite),
              const SizedBox(
                height: 13,
              ),
              const ProfileMenu(title: 'Bookmark', icons: Icons.book),
              const SizedBox(
                height: 13,
              ),
              const ProfileMenu(title: 'User Management', icons: Icons.person_2),
              const SizedBox(
                height: 50,
              ),
              const ProfileMenu(title: 'Log out', icons: Icons.logout),
            ],
          ),
        ),
      ),
    );
  }
}
