import 'package:flutter/material.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/pages/search/widget/search_history.dart';

class SearchView extends StatefulWidget {
  
  static route() => MaterialPageRoute(
        builder: (context) => const SearchView(),
      );
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 50,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: const EdgeInsets.only(left: 50, bottom: 7 ),
            title : Container(
              width: MediaQuery.of(context).size.width-100,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: 40,
              decoration: BoxDecoration(
                        color:PJcolor.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
              child : TextFormField(
              decoration: const InputDecoration(
                
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                hintText: 'Tìm kiếm các điểm du lịch', 
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: PJcolor.primaryColor2,
                )
              ),
             ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                '   Tìm kiếm gần đây',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "noto",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB( 30 , 30, 10, 0), // Đặt padding cho Column
                child: Column(
                  children: <Widget>[
                    SearchText(inputString: "Tìm kiếm 1"),
                    SizedBox(height: 25,),
                    SearchText(inputString: "Tìm kiếm 2"),
                    SizedBox(height: 25,),
                    SearchText(inputString: "Tìm kiếm 3"),
                    SizedBox(height: 25,),
                    SearchText(inputString: "Tìm kiếm 4"),
                    SizedBox(height: 25,),
                    SearchText(inputString: "Tìm kiếm 5"),
                    SizedBox(height: 25,),
                   
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );

  }
}