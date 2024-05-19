// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/auth/widget/custom_alert_box.dart';
import 'package:travelblog/features/pages/reviewblog/blog_card.dart';
import 'package:travelblog/features/pages/search/widget/search_history.dart';
import 'package:travelblog/provider/supabase_manager.dart';

final supabase = Supabase.instance.client;

class SearchView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SearchView(),
      );
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SupabaseManager supabaseManager = SupabaseManager();
  final search = TextEditingController();
  List<Map<String, dynamic>> searchedPost = [];
  List<Map<String, dynamic>> searchedHistory = [];
  bool isSearched = false;

  handleGuestSearch(String text) async {
    var posts = await supabaseManager.getPostBasedOnSearch(text);
    setState(() {
      searchedPost = posts.reversed.toList();
      isSearched = true;
    });
  }

  handleUserSearch(String text) async {
    var posts = await supabaseManager.getPostSearchedByUser(
        supabase.auth.currentUser?.id, text);
    setState(() {
      searchedPost = posts.reversed.toList();
      isSearched = true;
      getSearchHistory();
    });
  }

  getSearchHistory() async {
    var searches = await supabaseManager
        .getuserSearchHistory(supabase.auth.currentUser?.id);
    setState(() {
      searchedHistory = searches.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    if (supabase.auth.currentUser != null) {
      getSearchHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 50,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: const EdgeInsets.only(left: 50, bottom: 7),
            title: Row(children: [
              Container(
                width: MediaQuery.of(context).size.width - 100,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 40,
                decoration: BoxDecoration(
                  color: PJcolor.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  controller: search,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                      hintText: 'Tìm kiếm các điểm du lịch',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: PJcolor.primaryColor2,
                      )),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Container(
                width: 40,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        fixedSize: const Size(40, 40),
                        backgroundColor: PJcolor.primaryColor,
                        foregroundColor: PJcolor.primaryColor2),
                    onPressed: () {
                      if (search.text == "") {
                        var dialog = const CustomAlertDialog(
                            title: "Notice",
                            message: "Vui lòng nhập thông tin tìm kiếm");
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => dialog);
                      } else {
                        if (supabase.auth.currentUser == null) {
                          handleGuestSearch(search.text);
                        } else {
                          handleUserSearch(search.text);
                        }
                      }
                    },
                    child: Icon(Icons.search)),
              )
            ]),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              supabase.auth.currentUser != null && searchedHistory.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                            '   Tìm kiếm gần đây',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: "noto",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: searchedHistory.map<Widget>((search) {
                                return Column(
                                  children: [
                                  SearchText(
                                    inputString: search['searchContent'],
                                    handleTap: () => handleUserSearch(
                                        search['searchContent']),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ]);
                              }).toList(),
                            ),
                          )
                        ])
                  : Container(),
              searchedPost.isEmpty && isSearched == true
                  ? Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: Text(
                            "Không có bài viết nào trùng với dữ liệu đã tìm kiếm !",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ))
                  : Column(
                      children: searchedPost.map<Widget>((post) {
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
            ],
          ),
        ),
      ]),
    );
  }
}
