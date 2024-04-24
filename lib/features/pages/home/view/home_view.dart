import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/pages/pages.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          backgroundColor: Colors.white,
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey.withOpacity(0.3)),
              child: IconButton(
                icon: Icon(Icons.search),
                iconSize: 30,
                onPressed: () {},
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: IndexedStack(
            index: _page,
            children: AppPages.bottomTabBarPages,
          ),
        )
      ]),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey.withOpacity(0.1)),
              child: Icon(
                _page == 0 ? Icons.home : Icons.home_outlined,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.1)),
                child: Icon(
                  _page == 1
                      ? Icons.filter_alt_rounded
                      : Icons.filter_alt_outlined,
                ),
              ),
              label: 'Lọc'),
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.1)),
                child: Icon(
                  _page == 2 ? Icons.create : Icons.create_outlined,
                ),
              ),
              label: 'Tạo bài viết'),
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.1)),
                child: Icon(
                  _page == 3 ? Icons.person : Icons.person_outline,
                ),
              ),
              label: 'Profile'),
        ],
        activeColor: PJcolor.buttonColor, // Màu của nhãn khi được chọn
        inactiveColor: Colors.grey, // Màu của nhãn khi không được chọn
        height: 60,
      ),
    );
  }
}
