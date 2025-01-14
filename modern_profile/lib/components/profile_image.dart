import 'package:flutter/material.dart';
import 'package:modern_profile/constant/constant.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundColor:Colors.black,
            radius: 70,
            child: CircleAvatar(
              radius: 65,
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
          ),
          CircleAvatar(
            backgroundColor: bgPrimaryColor,
            radius: 22,
            child: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(
                Icons.edit,
                size: 22,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
