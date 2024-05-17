import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travelblog/features/pages/reviewblog/blog_list.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    height: 230,
                    child: 
                      Image.network("https://i1-dulich.vnecdn.net/2021/10/23/49483719-10115915-image-a-11-1634848573982.jpg?w=1200&h=0&q=100&dpr=2&fit=crop&s=x2JS8CGE41SJMc07-GfXPw", fit: BoxFit.cover,)
                  ),
                   Positioned(
                    bottom: 120,
                    left: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 75,
                      child: CircleAvatar(
                        radius: 72,
                        backgroundImage: NetworkImage("https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512"),
                      ),
                    )
                  ),
                  const Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sun Slave",
                          style: TextStyle(
                            fontFamily: 'noto',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            ),
                        ),
                        Text(
                          "@vuachichcho",
                          style: TextStyle(
                            color: Colors.grey, fontSize: 16,
                            fontFamily: "noto"
                            ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "I love chichcho, toi có một con mèo biết bucu",
                          style: TextStyle(
                            fontFamily: 'noto',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.visible
                            ),
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
            SizedBox(height: 30,),
            Text("    Bài viết của Sun Slave:", style: TextStyle(
              fontSize: 20,
              fontFamily: "noto",
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 10,),
            BlogList(),
          ],
      ),
    );
  }
}
