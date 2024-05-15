import 'package:flutter/material.dart';
import 'package:travelblog/features/pages/profile/view/user_profile_view.dart';
import 'package:travelblog/features/pages/reviewblog/blog_list.dart';
import 'package:travelblog/features/pages/writeblog/view/blog_create.dart';

class AppPages {
  static List<Widget> bottomTabBarPages = [
    BlogList(),
    Text("FilterScreen"),
    BlogCreate(),
    UserProfile(),
  ];
}
