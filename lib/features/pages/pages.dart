import 'package:flutter/material.dart';
import 'package:travelblog/features/pages/reviewblog/blog_list.dart';
import 'package:travelblog/features/pages/filter/filter_view.dart';

class AppPages {
  static List<Widget> bottomTabBarPages = [
    BlogList(),
    FilterView(),
    Text("WriteScreen"),
    Text("ProfileScreen")
  ];
}
