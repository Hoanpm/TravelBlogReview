// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, sized_box_for_whitespace
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/auth/widget/auth_field.dart';
import 'package:travelblog/features/auth/widget/custom_alert_box.dart';
import 'package:travelblog/features/pages/home/view/home_view.dart';
import 'package:travelblog/features/pages/login_alert/view/login_alert_view.dart';
import 'package:travelblog/features/pages/writeblog/widget/dropdown_component.dart';
import 'package:travelblog/provider/supabase_manager.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';

final supabase = Supabase.instance.client;

class BlogCreate extends StatefulWidget {
  const BlogCreate({super.key});
  @override
  State<BlogCreate> createState() => _BlogCreateState();
}

class _BlogCreateState extends State<BlogCreate> {
  final location = TextEditingController();
  final title = TextEditingController();
  final content = TextEditingController();
  SupabaseManager supabaseManager = SupabaseManager();
  List<String> cityList = [];
  String? selectedCity = "";
  List<String> districtSet = [];
  String? selectedDistrict = "";
  String? category = "";
  final GlobalKey<CustomDropdownState> districtDropdownKey =
      GlobalKey<CustomDropdownState>();
  String? _imageUrl = "";
  String? _videoUrl = "";
  String? ggLink = "";
  TextEditingController _textEditingController = TextEditingController();
  List<String> travelTypes = [
    'Ẩm Thực',
    'Tham quan',
  ];

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
    getCityList();
    getDistrictList();
  }

  @override
  void dispose() {
    super.dispose();
    location.dispose();
    content.dispose();
  }

  Future<void> handleSubmit() async {
    try {
      await supabase.from('post').insert({
        'user_id': supabase.auth.currentUser?.id,
        'category_id': travelTypes.indexOf(category!) + 1,
        'title': title.text,
        'detail_location': location.text,
        'content': content.text,
        'city_id': cityList.indexOf(selectedCity!) + 1,
        'district_id': districtSet.indexOf(selectedDistrict!) + 1,
        'map_link': ggLink,
        'image_link': _imageUrl,
        'video_link': _videoUrl ?? ""
      });

      if (!context.mounted) return;
      Navigator.push(context, HomeView.route());
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return supabase.auth.currentUser == null
        ? LoginAlert()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              toolbarHeight: 200,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 170,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(115, 115, 115, 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomDropdown(
                                items: travelTypes,
                                hintText: "Thể loại",
                                onChanged: (String? value) {
                                  setState(() {
                                    category = value;
                                  });
                                },
                              ),
                            ],
                          )),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Nhập link google map"),
                                  surfaceTintColor: Colors.white,
                                  content: TextField(
                                    
                                    controller: _textEditingController,
                                    decoration: InputDecoration(
                                      hintText: "Link...",
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 170,
                            height: 48,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(115, 115, 115, 1),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Map",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 170,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(115, 115, 115, 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomDropdown(
                                items: cityList,
                                hintText: "Tỉnh/Thành",
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedCity = value;
                                    getDistrictList();
                                  });
                                },
                              ),
                            ],
                          )),
                        ),
                        Container(
                          width: 170,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(115, 115, 115, 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomDropdown(
                                key: districtDropdownKey,
                                items: districtSet.toList(),
                                hintText: "Quận/Huyện",
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedDistrict = value;
                                  });
                                },
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 345,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            final userId = supabase.auth.currentUser!.id;
                            final ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (image == null) {
                              return;
                            }
                            DateTime now = DateTime.now();

                            DateFormat formatter =
                                DateFormat('yyyy-MM-dd HH:mm:ss');
                            String formatted = formatter.format(now);
                            final imageExtension =
                                image.path.split('.').last.toLowerCase();
                            final imageBytes = await image.readAsBytes();
                            final imagePath = '/$userId/$formatted';
                            await supabase.storage
                                .from('postImages')
                                .uploadBinary(imagePath, imageBytes,
                                    fileOptions: FileOptions(
                                        contentType: 'image/$imageExtension'));
                            final imageUrl = supabase.storage
                                .from('postImages')
                                .getPublicUrl(imagePath);
                            setState(() {
                              _imageUrl = imageUrl;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(115, 115, 115, 1),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.perm_media),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Thêm đa phương tiện")
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30, top: 20, right: 30),
                    child: Column(
                      children: [
                        AuthField(
                          controller: title,
                          hintText: "Tiêu đề ...",
                          ishiddenText: false,
                        ),
                        AuthField(
                          controller: location,
                          hintText: "Địa chỉ ...",
                          ishiddenText: false,
                        ),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: TextFormField(
                              controller: content,
                              expands: true,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintText: "Nội dung bài viết ...",
                                  hintStyle: TextStyle(
                                      color: PJcolor.primaryColor2,
                                      fontSize: 20,
                                      fontFamily: "noto",
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.visible),
                                  border: InputBorder.none)),
                        ),
                      ],
                    ),
                  ),
                  _imageUrl != ""
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            _imageUrl!,
                            fit: BoxFit.cover,
                          ))
                      : Container(),
                  SizedBox(
                    height: 70,
                  ),
                  
                ],
              ),
            ),
            bottomSheet: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 0.25,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                )
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (title.text == "" ||
                          location.text == "" ||
                          content.text == "" ||
                          selectedCity == "" ||
                          selectedDistrict == "" ||
                          category == "" ||
                          _imageUrl == "") {
                        var dialog = const CustomAlertDialog(
                            title: "Notice",
                            message: "Bạn cần chọn hết nội dung để đăng bài !");
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => dialog);
                      } else {
                        handleSubmit();
                      }
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: PJcolor.buttonColor,
                      ),
                      child: Center(
                        child: Text(
                          'Đăng bài',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
