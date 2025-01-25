import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final int index;
  final String postDescription;
  final String postImage; // เพิ่มตัวแปรรับค่าภาพ

  const PostDetailPage({super.key, required this.index, required this.postDescription, required this.postImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Post Title ${index + 1}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset(postImage), // แสดงรูปที่ส่งมาจาก HomePage
            const SizedBox(height: 20),
            Text(
              'Description: $postDescription',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
