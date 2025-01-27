import 'package:flutter/material.dart';
import 'package:modern_profile/screens/homescreen/comment_page.dart'; // นำเข้าไฟล์ CommentPage
import 'data.dart'; // นำเข้าไฟล์ data.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isFavorite = List.generate(8, (_) => false);
  List<bool> isBookmarked = List.generate(8, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: postTitles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ส่วนชื่อผู้โพสต์
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(userImages[index]), // รูปโปรไฟล์ของผู้ใช้
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        userNames[index], // ชื่อผู้ใช้
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // รูปภาพโพสต์
                Image.asset(
                  postImages[index],
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                // ส่วนแถบปุ่ม (Favorite, Bookmark, Comment)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isFavorite[index] ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite[index] ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorite[index] = !isFavorite[index];
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            isBookmarked[index] ? Icons.bookmark : Icons.bookmark_border,
                            color: isBookmarked[index] ? Colors.blue : null,
                          ),
                          onPressed: () {
                            setState(() {
                              isBookmarked[index] = !isBookmarked[index];
                            });
                          },
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentPage(
                              postImage: postImages[index],
                              postTitle: postTitles[index],
                              postDescription: postDescriptions[index],
                              postUser: userNames[index],
                              postComments: postComments[index],
                              postCommentUsers: commentUsers[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                // คำอธิบายโพสต์
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    postDescriptions[index],
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                // แสดงคอมเมนต์ 1 ข้อ พร้อมชื่อคนคอมเมนต์
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    postComments[index].isNotEmpty ? '${commentUsers[index][0]}: ${postComments[index][0]}' : 'No comments yet.',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
