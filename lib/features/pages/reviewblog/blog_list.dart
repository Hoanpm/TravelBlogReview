import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travelblog/features/pages/reviewblog/blog_card.dart';

class BlogList extends ConsumerWidget {
  const BlogList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
       
        BlogCard(imageUrl: "https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512", textContent: "Tôi mới đi chịch chó với chịch gay, hiện đang luyện bú cu tại đảo gay và thành master gay", time: "11:00 PM", like: 100000, comment: 20000, fullName: "Sun Slave", userName: "vuachoigay"),
        BlogCard(imageUrl: "https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512", textContent: "Tôi mới đi chịch chó với chịch gay, hiện đang luyện bú cu tại đảo gay và thành master gay", time: "11:00 PM", like: 100000, comment: 20000, fullName: "Sun Slave", userName: "vuachoigay"),
        BlogCard(imageUrl: "https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512", textContent: "Tôi mới đi chịch chó với chịch gay, hiện đang luyện bú cu tại đảo gay và thành master gay", time: "11:00 PM", like: 100000, comment: 20000, fullName: "Sun Slave", userName: "vuachoigay"),
        BlogCard(imageUrl: "https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512", textContent: "Tôi mới đi chịch chó với chịch gay, hiện đang luyện bú cu tại đảo gay và thành master gay", time: "11:00 PM", like: 100000, comment: 20000, fullName: "Sun Slave", userName: "vuachoigay"),
      ],
    );
  }
}
