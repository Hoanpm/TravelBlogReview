import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/pages/reviewblog/blog_detail.dart';
import 'package:travelblog/features/pages/showblogdetail/view/showblogdetailview.dart';

class BlogCard extends StatelessWidget {
  final String imageUrl;
  final String textContent;
  final String time;
  final int like;
  final int comment;
  final String fullName;
  final String imageLink;
  final bool isEditable;
  final VoidCallback editNavigate;
  final Map<String, dynamic> post;
  final VoidCallback onTap;

  const BlogCard({
    super.key,
    required this.imageUrl,
    required this.textContent,
    required this.time,
    required this.like,
    required this.comment,
    required this.fullName,
    required this.imageLink,
    required this.isEditable,
    required this.editNavigate,
    required this.post, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 250,
        margin: EdgeInsets.all(20),
        child: Stack(
          children: <Widget>[
            Container(
                height: 210,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        imageUrl,
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: Image.network(imageLink).image,
                          radius: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          fullName,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, color: Colors.white),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Text(
                      time,
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    Text(
                      textContent,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Positioned(
              top: 185,
              left: 20,
              child: Container(
                width: 180,
                height: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.25,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        IconButton(
                            iconSize: 20,
                            onPressed: () {},
                            icon: Icon(Icons.thumb_up)),
                        Text(
                          "$like",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        IconButton(
                            iconSize: 20,
                            onPressed: () {},
                            icon: Icon(Icons.comment)),
                        Text(
                          "$comment",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            isEditable == false
                ? Container()
                : Positioned(
                    top: 16,
                    right: 10,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: PJcolor.buttonColor,
                            foregroundColor: Colors.white),
                        onPressed: editNavigate,
                        child: Center(
                          child: Text("Chỉnh sửa"),
                        )))
          ],
        ),
      ),
    );
  }
}
