import 'package:flutter/material.dart';
import 'package:travelblog/features/pages/showblogdetail/widget/comment_component.dart.dart';

class CommentList extends StatefulWidget {
  final List<Map<String, dynamic>> cmtList;
  const CommentList({super.key, required this.cmtList});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.cmtList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: CommentComponent(cmt: widget.cmtList[index],),
        );
      },
    );
  }
}
