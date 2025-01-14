import 'package:flutter/material.dart';
import 'package:modern_profile/components/profile_image.dart';
import 'package:modern_profile/components/profile_menu.dart';
import 'package:modern_profile/constant/constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedItem = 0;

  void _navigationBottonNavBar(int index) {
    setState(() {
      _selectedItem = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 25,
          color: iconGreyColor,
        ),
        title: Center(
            child: Text(
          'Edit Profile',
          style: textTitle,
        )),
        actions: const [
          Icon(
            Icons.exit_to_app,
            size: 30,
            color: iconGreyColor,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                color: Colors.amber,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Center(
                  child: Text(
                'Edit Profile',
                style: textBtn,
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
            const ProfileMenu(title: 'Billing Detail', icons: Icons.wallet),
            const SizedBox(
              height: 13,
            ),
            const ProfileMenu(title: 'User Management', icons: Icons.person_2),
            const SizedBox(
              height: 13,
            ),
            const ProfileMenu(title: 'Bookmark', icons: Icons.book),
            const SizedBox(
              height: 50,
            ),
            const ProfileMenu(title: 'Log out', icons: Icons.logout),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedItem,
        onTap: _navigationBottonNavBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: iconGreyColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30,
              color: iconGreyColor,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 30,
              color: iconGreyColor,
            ),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
              color: iconGreyColor,
            ),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
