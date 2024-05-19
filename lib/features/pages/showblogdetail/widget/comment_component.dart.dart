import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travelblog/color/color.dart';

class CommentComponent extends StatefulWidget {
  const CommentComponent({super.key});

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
                backgroundImage: Image.network("https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512").image,
                radius: 20,
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PJcolor.primaryColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text(
                            "Sun Slave",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: "noto"),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "@vuachichcho",
                            style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: "noto"),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Âu Cảng một địa điểm còn khá mới ở Cô Tô, nằm gần bãi đá Cầu Mỵ. Đây cũng là cảng tránh bão lớn nhất ở Cô Tô. Bạn có thể chụp những tấm hình cực chất, cực đẹp “check-in” tại đây.",
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
          Padding(
            padding: const EdgeInsets.only(left: 60, top : 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up, size: 16,),
                    SizedBox(width: 5),
                    Text('100',
                    style: TextStyle(fontSize: 16, ), ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
