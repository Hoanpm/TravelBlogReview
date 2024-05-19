import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/auth/widget/custom_alert_box.dart';
import 'package:travelblog/features/pages/filter/widget/dropdown_component1.dart';
import 'package:travelblog/features/pages/reviewblog/blog_card.dart';
import 'package:travelblog/provider/supabase_manager.dart';

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
  SupabaseManager supabaseManager = SupabaseManager();
  List<String> cityList = [];
  String? selectedCity = "";
  List<String> districtSet = [];
  String? selectedDistrict = "";
  List<Map<String, dynamic>> filteredPost = [];
  final GlobalKey<CustomDropDown2State> districtDropdownKey =
      GlobalKey<CustomDropDown2State>();
  final GlobalKey<CustomDropDown2State> cityDropdownKey =
      GlobalKey<CustomDropDown2State>();
  final GlobalKey<CustomDropDown2State> categoryDropdownKey =
      GlobalKey<CustomDropDown2State>();
  String? category = "";
  List<String> travelTypes = [
    'Ẩm Thực',
    'Tham quan',
  ];
  bool isFilterd = false;

  getCityList() async {
    var cities = await supabaseManager.getCityList();
    setState(() {
      cities.map((item) => cityList.add(item['name'] as String)).toList();
    });
  }

  getDistrictList() async {
    var districts = await supabaseManager
        .getDistrictList(cityList.indexOf(selectedCity!) + 1);
    setState(() {
      districtDropdownKey.currentState?.setSelectedValue();
      districtSet.clear();
      districts.forEach((item) {
        districtSet.add(item['name'] as String);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    getCityList();
    getDistrictList();
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

  handleGetFilterdPost() async {
    var posts = await supabaseManager.getPostBasedOnFilter(
        travelTypes.indexOf(category!) + 1,
        cityList.indexOf(selectedCity!) + 1,
        districtSet.indexOf(selectedDistrict!) + 1);

    setState(() {
      filteredPost = posts;
      isFilterd = true;
      districtDropdownKey.currentState?.setSelectedValue();
      cityDropdownKey.currentState?.setSelectedValue();
      categoryDropdownKey.currentState?.setSelectedValue();
      selectedCity = "";
      selectedDistrict = "";
      category = "";
      districtSet.clear();
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
                          key: categoryDropdownKey,
                          items: travelTypes,
                          hintText: "Chọn loại hình du lịch",
                          onChanged: (String? value) {
                            setState(() {
                              category = value;
                            });
                          },
                        ),
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
                          key: cityDropdownKey,
                          items: cityList,
                          hintText: "Chọn tỉnh thành du lịch",
                          onChanged: (String? value) {
                            setState(() {
                              selectedCity = value;
                              getDistrictList();
                            });
                          },
                        ),
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
                          key: districtDropdownKey,
                          items: districtSet,
                          hintText: "Chọn quận huyện du lịch",
                          onChanged: (String? value) {
                            setState(() {
                              selectedDistrict = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(100, 45),
                                  backgroundColor: PJcolor.buttonColor,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                if (category == "" &&
                                    selectedCity == "" &&
                                    selectedDistrict == "") {
                                  var dialog = const CustomAlertDialog(
                                      title: "Notice",
                                      message:
                                          "Bạn cần chọn ít nhất một nội dung để lọc !");
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          dialog);
                                } else {
                                  handleGetFilterdPost();
                                }
                              },
                              child: Center(
                                child: Text(
                                  "Lọc",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'noto',
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        )
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
              filteredPost.isEmpty && isFilterd == true
                  ? Center(
                      child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Text("Không tìm thấy kết quả phù hợp !")),
                    )
                  : Column(
                      children: filteredPost.map<Widget>((post) {
                        return BlogCard(
                          imageUrl: post['image_link'],
                          textContent: post['title'],
                          time: DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(DateTime.parse(post['created_at'])),
                          like: post['like'],
                          comment: 0,
                          fullName: post['user_fullName'],
                          imageLink: post['user_image_link'],
                          isEditable: false, editNavigate: () {},
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
