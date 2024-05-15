import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/pages/pages.dart';
import 'package:travelblog/features/pages/search/View/search_view.dart';

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
          toolbarHeight: 50,
          floating: true,
          automaticallyImplyLeading: false,
          pinned: false,
          backgroundColor: Colors.white,
          actions: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey.withOpacity(0.1), ),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.search),
                  iconSize: 25,
                  onPressed: () {
                    Navigator.push(context, SearchView.route());
                  },
                ),
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
            icon:Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey.withOpacity(0.1)),
              child: Icon(
                _page == 0 ? Icons.home : Icons.home_outlined,
              ),
            ),
          ),
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.1)),
                child: Icon(
                  _page == 1
                      ? Icons.filter_alt_rounded
                      : Icons.filter_alt_outlined,
                ),
              ),
            ),
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.1)),
                child: Icon(
                  _page == 2 ? Icons.create : Icons.create_outlined,
                ),
              ),
            ),
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.1)),
                child: Icon(
                  _page == 3 ? Icons.person : Icons.person_outline,
                ),
              ),
            ),
        ],
        activeColor: PJcolor.buttonColor, // Màu của nhãn khi được chọn
        inactiveColor: Colors.grey, // Màu của nhãn khi không được chọn
        height: 50,
      ),
    );
  }
}
