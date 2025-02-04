import 'package:flutter/material.dart';
import 'package:modern_profile/constant/constant.dart';
import 'profile_dialog.dart'; // นำเข้าไฟล์ profile_dialog.dart
import 'data.dart'; // นำเข้าไฟล์ data.dart

class CommentPage extends StatefulWidget {
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
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  // ใช้ separate variables สำหรับการกดใจโพสต์และคอมเมนต์
  bool isPostFavorite = false; // กดใจในโพสต์
  List<bool> isFavorite = []; // กดใจในคอมเมนต์

  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // กำหนดค่าเริ่มต้นให้กับสถานะการกดใจของแต่ละคอมเมนต์
    isFavorite = List.generate(widget.postComments.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    // หาตำแหน่งของผู้โพสต์ในฐานข้อมูล
    int postUserIndex = userNames.indexOf(widget.postUser);

    return Scaffold(
      backgroundColor: bgPostColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showProfileDialog(context, postUserIndex); // เรียกใช้ฟังก์ชันจากไฟล์แยก
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage(userImages[postUserIndex]), // รูปจาก data.dart
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.postUser,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        widget.postImage,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 250.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.postTitle,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                isPostFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isPostFavorite ? iconRedColor : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPostFavorite = !isPostFavorite;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.postUser}: ${widget.postDescription}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: widget.postComments.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "ยังไม่มีคอมเมนต์",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: widget.postComments.length,
                        itemBuilder: (context, index) {
                          int userIndex =
                              userNames.indexOf(widget.postCommentUsers[index]);

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: bgPostColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                leading: GestureDetector(
                                  onTap: () {
                                    showProfileDialog(context, userIndex); // เรียกใช้ฟังก์ชันจากไฟล์แยก
                                  },
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(userImages[userIndex]), // รูปจาก data.dart
                                  ),
                                ),
                                title: Text(widget.postCommentUsers[index],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                  widget.postComments[index],
                                  style: const TextStyle(fontSize: 14),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    isFavorite[index]
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite[index]
                                        ? iconRedColor
                                        : null,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFavorite[index] = !isFavorite[index];
                                    });
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _commentController,
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
                          widget.postComments.add(_commentController.text); // เพิ่มคอมเมนต์
                          widget.postCommentUsers.add('me'); // เพิ่มชื่อผู้ใช้เป็น 'me'
                          isFavorite.add(false); // เพิ่มสถานะการกดใจใหม่
                          _commentController.clear(); // ล้างช่องกรอก
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
