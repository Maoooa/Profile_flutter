import 'package:flutter/material.dart';
import 'data.dart'; // นำเข้าไฟล์ data.dart

class CommentPage extends StatelessWidget {
  final String postImage;
  final String postTitle;
  final String postDescription;
  final String postUser;
  final List<String> postComments;
  final List<String> postCommentUsers;

  const CommentPage({
    super.key,
    required this.postImage,
    required this.postTitle,
    required this.postDescription,
    required this.postUser,
    required this.postComments,
    required this.postCommentUsers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ส่วนโพสต์ (รูป + คำอธิบาย)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // รูปภาพโพสต์
                AspectRatio(
                  aspectRatio: 16 / 9, // ตั้งอัตราส่วนที่ต้องการ เช่น 16:9
                  child: Image.asset(
                    postImage,
                    width: double.infinity,
                    fit: BoxFit.cover, // ปรับขนาดให้เต็มพื้นที่
                  ),
                ),
                const SizedBox(height: 10),
                // ชื่อโพสต์
                Text(
                  postTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                // คำอธิบายโพสต์
                Text(
                  postDescription,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const Divider(),
          // ส่วนคอมเมนต์
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Comments',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: postComments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                  title: Text(postCommentUsers[index]),
                  subtitle: Text(postComments[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
