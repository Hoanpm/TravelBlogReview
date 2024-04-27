import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/pages/reviewblog/blog_list.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
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
                    Image.network("https://static.topcv.vn/company_logos/XNmAj34dlkgUnHAumzR8wV1glpK2vUGM_1644916299____dd352cc1e6550dc1569aae2ab8d87282.png", fit: BoxFit.cover,)
                ),
                const Positioned(
                  bottom: 120,
                  left: 20,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512"),
                    radius: 80
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
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "I love chichcho, toi có một con mèo biết bucu",
                        style: TextStyle(
                          fontFamily: 'arial',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          ),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
          SizedBox(height: 30,),
          Text(" Bài viết của Sun Slave:", style: TextStyle(
            fontSize: 20,
            fontFamily: "noto",
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 10,),
          BlogList(),
        ],
    );
  }
}
