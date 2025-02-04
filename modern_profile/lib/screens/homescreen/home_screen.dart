import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modern_profile/constant/constant.dart';
import 'package:modern_profile/screens/homescreen/comment_page.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
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
  final List<TextEditingController> _commentControllers = List.generate(
      8, (_) => TextEditingController()); // สำหรับช่องกรอกคอมเมนต์ในแต่ละโพสต์
  List<List<String>> newComments =
      List.generate(8, (_) => []); // เก็บคอมเมนต์ใหม่ของแต่ละโพสต์
  final List<FocusNode> _focusNodes =
      List.generate(8, (_) => FocusNode()); // สำหรับการจัดการโฟกัส

  @override
  void dispose() {
    // ควร dispose ของ FocusNode และ TextEditingController เพื่อป้องกัน Memory leak
    for (var controller in _commentControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // ฟังก์ชันแสดง Dialog เมื่อกดที่โปรไฟล์
  void showProfileDetails(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: 300, // กำหนดความกว้างของ Dialog
            height: 220, // ปรับขนาดให้พอดี
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // รูปโปรไฟล์ตรงกลาง
                CircleAvatar(
                  backgroundImage: AssetImage(userImages[index]),
                  radius: 40, // ปรับขนาดรูปโปรไฟล์ใหญ่ขึ้นเล็กน้อย
                ),
                const SizedBox(height: 15), // เว้นระยะห่าง
                // ชื่อผู้ใช้ อยู่แถวที่ 2
                Text(
                  userNames[index],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5), // เว้นระยะห่าง
                // Bio อยู่แถวที่ 3
                Text(
                  userBios[index],
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center, // จัดให้ข้อความอยู่ตรงกลาง
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิด Dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int oldCommentsToShow = 2; // กำหนดจำนวนคอมเมนต์เก่าที่ต้องการแสดง

    return Scaffold(
      backgroundColor: Color(0xffb3bdca),
      body: Center(
        child: Container(
          width: 400,
          child: ListView.builder(
            itemCount: postTitles.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: bgPostColor,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar และชื่อผู้ใช้
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => showProfileDetails(context, index),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(userImages[index]),
                              radius: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            userNames[index],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    // รูปภาพโพสต์
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        postImages[index],
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // ปุ่ม Favorite / Bookmark / Comment
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                isFavorite[index]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite[index] ? iconRedColor : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  isFavorite[index] = !isFavorite[index];
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                isBookmarked[index]
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color:
                                    isBookmarked[index] ? iconSkyColor : null,
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
                          icon: const Icon(FontAwesomeIcons.comment),
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
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${userNames[index]} : ${postDescriptions[index]}', // เพิ่มชื่อผู้โพสต์ที่นี่
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    // คอมเมนต์ทั้งหมด
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (postComments[index].length > oldCommentsToShow
                                ? oldCommentsToShow
                                : postComments[index].length) + newComments[index].length,
                        itemBuilder: (context, commentIndex) {
                          if (commentIndex < (postComments[index].length > oldCommentsToShow
                              ? oldCommentsToShow
                              : postComments[index].length)) {
                            // แสดงคอมเมนต์เก่า
                            return Text(
                              "${commentUsers[index][commentIndex]}: ${postComments[index][commentIndex]}",
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            );
                          } else {
                            // คอมเมนต์ใหม่
                            int newIndex = commentIndex - (postComments[index].length > oldCommentsToShow
                                ? oldCommentsToShow
                                : postComments[index].length);
                            return Text(
                              "@Me: ${newComments[index][newIndex]}",
                              style: const TextStyle(fontSize: 14, color: Colors.black),
                            );
                          }
                        },
                      ),
                    ),
                    // ช่องกรอกคอมเมนต์ในแต่ละโพสต์
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 60.0, // ความสูงที่เพิ่มขึ้น
                        child: TextField(
                          controller: _commentControllers[index],
                          focusNode: _focusNodes[index],
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send, color: iconSkyColor),
                              onPressed: () {
                                setState(() {
                                  newComments[index].add(
                                      _commentControllers[index]
                                          .text); // เพิ่มคอมเมนต์ใหม่
                                  _commentControllers[index]
                                      .clear(); // ล้างช่องกรอก
                                  _focusNodes[index]
                                      .requestFocus(); // ให้โฟกัสกับช่องกรอก
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 12.0), // เพิ่ม padding ภายใน
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
