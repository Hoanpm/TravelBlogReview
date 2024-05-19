import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travelblog/color/color.dart';

class CommentComponent extends StatefulWidget {
  final Map<String, dynamic> cmt;
  const CommentComponent({super.key, required this.cmt});

  @override
  State<CommentComponent> createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.cmt['user_image_link']),
                radius: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PJcolor.primaryColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.cmt['user_fullName'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: "noto"),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "@${widget.cmt['user_username']}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontFamily: "noto"),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.cmt['content'],
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: "noto",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
