import 'package:flutter/material.dart';
import 'package:modern_profile/screens/homescreen/data.dart'; // ใช้ data.dart สำหรับข้อมูลของ user

void showProfileDialog(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          width: 300,
          height: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(userImages[index]), // รูปจาก data.dart
                radius: 40,
              ),
              const SizedBox(height: 15),
              Text(
                userNames[index],
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                userBios[index], // ใช้จาก data.dart
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
