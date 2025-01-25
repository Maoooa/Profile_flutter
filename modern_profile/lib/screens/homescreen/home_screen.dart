import 'package:flutter/material.dart';
import 'package:modern_profile/screens/homescreen/postdetailpage.dart'; // นำเข้าไฟล์ที่มีคลาส PostDetailPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // ปิดสัญลักษณ์ Debug
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

  static const List<String> postTitles = [
    'Post Title 1',
    'Post Title 2',
    'Post Title 3',
    'Post Title 4',
    'Post Title 5',
    'Post Title 6',
    'Post Title 7',
    'Post Title 8',
  ];

  static const List<String> postImages = [
    'images/imagesky.jpg',
    'images/jp1.jpg',
    'images/jp2.jpg',
    'images/jp3.jpg',
    'images/jp8.jpg',
    'images/jp5.jpg',
    'images/jp6.jpg',
    'images/jp9.jpg',
  ];

  static const List<String> postDescriptions = [
    'This is a detailed description of Post 1.',
    'This is a detailed description of Post 2.',
    'This is a detailed description of Post 3.',
    'This is a detailed description of Post 4.',
    'This is a detailed description of Post 5.',
    'This is a detailed description of Post 6.',
    'This is a detailed description of Post 7.',
    'This is a detailed description of Post 8.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView( // ใช้ SingleChildScrollView ครอบ Column
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.75,
                ),
                itemCount: postTitles.length,
                shrinkWrap: true, // ทำให้ GridView ใช้พื้นที่ที่มีอยู่
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(postImages[index]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            postTitles[index],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'This is the description of post number ${index + 1}.',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // จัดให้ปุ่มอยู่ซ้ายขวา
                          children: [
                            // ปุ่ม Read More อยู่ทางซ้าย
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostDetailPage(
                                      index: index,
                                      postDescription: postDescriptions[index],
                                      postImage: postImages[index], // ส่งค่าภาพไปยังหน้า PostDetailPage
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Read More'),
                            ),
                            // ปุ่ม Favorite
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
                            // ปุ่ม Bookmark
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
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
