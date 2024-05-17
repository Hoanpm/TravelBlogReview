// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelblog/features/pages/reviewblog/blog_card.dart';
import 'package:travelblog/provider/supabase_manager.dart';

final supabase = Supabase.instance.client;

class BlogList extends StatefulWidget {
  const BlogList({super.key});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  SupabaseManager supabaseManager = SupabaseManager();
  final userId = supabase.auth.currentUser?.id as String;
  List<Map<String, dynamic>> postList = [];
  List<Map<String, dynamic>> user = [];

  getPostList() async {
    var posts = await supabaseManager.getPostList();
    setState(() {
      postList = posts;
      print(postList);
    });
  }

  getUserInfo() async {
    var useri4 = await supabaseManager.getUserInfo(userId);
    setState(() {
      user = useri4;
      print(user);
    });
  }

  @override
  void initState() {
    super.initState();
    getPostList();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (postList.isEmpty || user.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SingleChildScrollView(
        child: Column(
          children: postList.map<Widget>((post) {
            return BlogCard(
              imageUrl: post['image_link'],
              textContent: post['title'],
              time: DateFormat('yyyy-MM-dd HH:mm:ss')
                  .format(DateTime.parse(post['created_at'])),
              like: post['like'],
              comment: 0,
              fullName: user[0]['fullName'],
              userName: user[0]['username'],
            );
          }).toList(),
        ),
      );
    }
  }
}
