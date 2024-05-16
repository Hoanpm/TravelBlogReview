import 'package:flutter/material.dart';

class BlogDetail extends StatefulWidget {

  static route() => MaterialPageRoute(
        builder: (context) => const BlogDetail(),
      );

  const BlogDetail({super.key,});

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  String? selectedTravelType;
  @override
  Widget build(BuildContext context) {
    final String fullname = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(fullname),
      ),
    );
  }
}