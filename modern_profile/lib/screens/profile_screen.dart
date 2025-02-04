import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modern_profile/constant/constant.dart';
import 'package:modern_profile/main.dart';
import 'package:modern_profile/screens/editprofilescreen.dart';
import 'package:modern_profile/screens/homescreen/home_screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedItem = 0;

  void _navigationBottomNavBar(int index) {
    setState(() {
      _selectedItem = index;
      print(index);
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text('Favorite')),
    const Center(child: Text('Setting')),
    const EditProfileScreen(),
  ] ;

  final List<String> _titles = [
      'Home',
      'Favorite',
      'Setting',
      'Edit Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgPostColor,
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 25,
          color: iconSkyColor,
        ),
        title: Center(
          child: Text(
          _titles[_selectedItem],
          style: textTitle,
        )),
        actions: const [
          Icon(
            FontAwesomeIcons.signOutAlt,
            size: 25,
            color: iconSkyColor,
          ),
          SizedBox(
            width: 10,
          )
          
        ],
      ),
      body: _pages[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bgPostColor,
        currentIndex: _selectedItem,
        onTap: _navigationBottomNavBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: iconSkyColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30,
              color: iconSkyColor,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 30,
              color: iconSkyColor,
            ),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
              color: iconSkyColor
            ),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
