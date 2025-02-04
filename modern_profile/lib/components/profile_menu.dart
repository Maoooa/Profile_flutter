import 'package:flutter/material.dart';
import 'package:modern_profile/constant/constant.dart';

class ProfileMenu extends StatelessWidget {
  final String title;
  final IconData icons;
  
  const ProfileMenu({
    Key? key,
    required this.title, 
    required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 250,
      height: 40,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconSkyColor,
            child: Icon(
              icons,
              size: 24,
              color: iconSecondaryColor,
            ),
          ),
          const SizedBox(
            width: 9,
          ), //ระยะห่างระหว่าง windget ได้ทั้งบนและล่าง
          Text(
            title,
            style: textMenu,
          ),
          const SizedBox(
            width: 9,
          ),
          const Spacer(),
          const CircleAvatar(
            radius: 16,
            backgroundColor: iconSkyColor,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: bgPostColor,
            ),
          )
        ],
      ),
    );
  }
}
