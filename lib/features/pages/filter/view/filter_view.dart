import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/pages/filter/widget/dropdown_component1.dart';
import 'package:travelblog/features/pages/reviewblog/blog_list.dart';

final supabase = Supabase.instance.client;

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  bool _isAppBarVisible = true;
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  List<String> travelTypes = [
    'Ẩm Thực',
    'Tham quan',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }


  void _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      if (_scrollPosition >= 100) {
        _isAppBarVisible = false;
      } else {
        _isAppBarVisible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isAppBarVisible
          ? AppBar(
              toolbarHeight: 270,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: CustomDropDown2(
                            items: travelTypes,
                            hintText: "Chọn loại hình du lịch"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: CustomDropDown2(
                            items: travelTypes,
                            hintText: "Chọn tỉnh thành du lịch"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: CustomDropDown2(
                            items: travelTypes,
                            hintText: "Chọn quận huyện du lịch"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 290,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 45),
                            backgroundColor: PJcolor.buttonColor,
                          ),
                          child: Text(
                            "Lọc",
                            style: const TextStyle(
                              color: Colors.white, // Màu văn bản
                              fontFamily: "noto",
                              fontSize: 18, // Cỡ chữ
                              fontWeight: FontWeight.bold, // Độ đậm của chữ
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : PreferredSize(
              child: Container(), // Ẩn AppBar
              preferredSize: Size(0.0, 0.0),
            ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kết quả tìm kiếm",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "noto",
                  fontWeight: FontWeight.bold,
                ),
              ),
              BlogList()
            ],
          ),
        ),
      ),
    );
  }
}
