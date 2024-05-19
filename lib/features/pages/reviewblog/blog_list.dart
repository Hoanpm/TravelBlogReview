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
  List<Map<String, dynamic>> postList = [];

  getPostList() async {
    var posts = await supabaseManager.getPostList();
    setState(() {
      postList = posts.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getPostList();
  }

  @override
  Widget build(BuildContext context) {
    if (postList.isEmpty) {
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
              fullName: post['user_fullName'],
              imageLink: post['user_image_link'],
              isEditable: false,
              editNavigate: () {},
            );
          }).toList(),
        ),
      );
    }
  }
}
