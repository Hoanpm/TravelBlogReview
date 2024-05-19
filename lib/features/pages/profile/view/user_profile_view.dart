import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelblog/features/auth/view/getting_start_view.dart';
import 'package:travelblog/features/auth/view/login_view.dart';
import 'package:travelblog/features/pages/login_alert/view/login_alert_view.dart';
import 'package:travelblog/features/pages/profile/view/edit_post.dart';
import 'package:travelblog/features/pages/profile/view/edit_profile.dart';
import 'package:travelblog/features/pages/reviewblog/blog_card.dart';
import 'package:travelblog/features/pages/reviewblog/blog_list.dart';
import 'package:travelblog/features/pages/showblogdetail/view/showblogdetailview.dart';
import 'package:travelblog/provider/supabase_manager.dart';

final supabase = Supabase.instance.client;

class UserProfile extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const UserProfile());
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  SupabaseManager supabaseManager = SupabaseManager();
  Map<String, dynamic> user = {
    'image_link': '',
    'username': '',
    'fullName': ''
  };
  List<Map<String, dynamic>> postList = [];
  bool isGetUser = false;

  getUserInfo() async {
    var userInfo =
        await supabaseManager.getUserInfo(supabase.auth.currentUser?.id);
    setState(() {
      user = userInfo[0];
      isGetUser = true;
    });
  }

  getUserPostList() async {
    var posts =
        await supabaseManager.getUserPostList(supabase.auth.currentUser?.id);
    setState(() {
      postList = posts.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    if (supabase.auth.currentUser != null) {
      getUserPostList();
      getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return supabase.auth.currentUser == null
        ? LoginAlert()
        : SingleChildScrollView(
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
                              borderRadius: BorderRadius.circular(10)),
                          height: 230,
                          child: Image.network(
                            "https://i1-dulich.vnecdn.net/2021/10/23/49483719-10115915-image-a-11-1634848573982.jpg?w=1200&h=0&q=100&dpr=2&fit=crop&s=x2JS8CGE41SJMc07-GfXPw",
                            fit: BoxFit.cover,
                          )),
                      Positioned(
                          bottom: 120,
                          left: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 75,
                            child: CircleAvatar(
                              radius: 72,
                              backgroundImage: NetworkImage(user['image_link']),
                            ),
                          )),
                      Positioned(
                          bottom: 20,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['fullName'],
                                style: TextStyle(
                                  fontFamily: 'noto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                "@${user['username']}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "noto"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 170, 40),
                            backgroundColor: Color.fromRGBO(115, 115, 115, 1),
                            foregroundColor: Colors.white),
                        onPressed: () async {
                          final result = await Navigator.push(
                              context, EditProfileView.route());
                          if (result == true) {
                            getUserInfo();
                            getUserPostList();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit_note),
                            SizedBox(
                              width: 4,
                            ),
                            Text('Chỉnh sửa')
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(145, 40),
                            backgroundColor: Color.fromRGBO(115, 115, 115, 1),
                            foregroundColor: Colors.white),
                        onPressed: () async {
                          await supabase.auth.signOut();
                          if (!context.mounted) return;
                          Navigator.push(context, StartView.route());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout),
                            SizedBox(
                              width: 4,
                            ),
                            Text('Đăng xuất')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "    Bài viết của ${user['fullName']}:",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "noto",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                postList.isEmpty && isGetUser == true
                    ? Center(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text("Hiện chưa có bài viết nào !")),
                      )
                    : Column(
                        children: postList.map<Widget>((post) {
                          return BlogCard(
                            imageUrl: post['image_link'],
                            textContent: post['title'],
                            time: DateFormat('yyyy-MM-dd')
                                .format(DateTime.parse(post['created_at'])),
                            like: post['like'],
                            comment: post['comment_numb'],
                            fullName: post['user_fullName'],
                            imageLink: post['user_image_link'],
                            isEditable: true,
                            editNavigate: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditPostView(post: post),
                                ),
                              );
                              if (result == true) {
                                getUserPostList();
                              }
                            },
                            post: post,
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowDetail(post: post),
                                ),
                              );
                              if (result == true) {
                                setState(() {
                                  getUserPostList();
                                });
                              }
                            },
                          );
                        }).toList(),
                      ),
              ],
            ),
          );
  }
}
