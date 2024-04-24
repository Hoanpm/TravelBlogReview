import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travelblog/color/color.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlogCard extends StatelessWidget {
  final String imageUrl;
  final String textContent;
  final String time;
  final int like;
  final int comment;
  final String fullName;
  final String userName;

  const BlogCard({
    super.key,
    required this.imageUrl,
    required this.textContent,
    required this.time,
    required this.like,
    required this.comment, required this.fullName, required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: Image.network(imageUrl).image,
                    radius: 35,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            fullName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Text(
                            userName,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        time,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ],
              ),
              Text(
                textContent,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(child: Row(
                    children: [
                      Icon(Icons.thumb_up),
                      SizedBox(width: 5),
                      Text('$like'),
                    ],
                    )
                  ),
                  
                  Expanded(child: Row(
                    children: [
                      Icon(Icons.comment),
                      SizedBox(width: 5),
                      Text('$comment'),
                    ],
                    )
                  ),
                  
                ],
              )
            ],
          )),
    );
  }
}
