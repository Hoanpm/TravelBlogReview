import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travelblog/features/pages/reviewblog/blog_card.dart';

class BlogList extends ConsumerWidget {
  const BlogList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
       child : Column(
        children: [
          BlogCard(imageUrl: "https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512", textContent: "Địa điểm leo núi nổi tiếng nhất khu vực miến Bắc", time: "May, 15, 2024", like: 1000, comment: 2000, fullName: "Sun Slave", userName: "vuachoigay"),
          BlogCard(imageUrl: "https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512", textContent: "Địa điểm leo núi nổi tiếng nhất khu vực miến Bắc", time: "May, 15, 2024", like: 1000, comment: 2000, fullName: "Sun Slave", userName: "vuachoigay"),
          BlogCard(imageUrl: "https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512", textContent: "Địa điểm leo núi nổi tiếng nhất khu vực miến Bắc", time: "May, 15, 2024", like: 1000, comment: 2000, fullName: "Sun Slave", userName: "vuachoigay"),
          BlogCard(imageUrl: "https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512", textContent: "Địa điểm leo núi nổi tiếng nhất khu vực miến Bắc", time: "May, 15, 2024", like: 1000, comment: 2000, fullName: "Sun Slave", userName: "vuachoigay"),
        ],
      )
    );
  }
}
