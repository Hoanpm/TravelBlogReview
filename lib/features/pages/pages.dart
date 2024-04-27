import 'package:flutter/material.dart';
import 'package:travelblog/features/pages/profile/view/user_profile_view.dart';
import 'package:travelblog/features/pages/reviewblog/blog_list.dart';

class AppPages {
  static List<Widget> bottomTabBarPages = [
    BlogList(),
    Text("FilterScreen"),
    Text("WriteScreen"),
    UserProfile(),
  ];
}
