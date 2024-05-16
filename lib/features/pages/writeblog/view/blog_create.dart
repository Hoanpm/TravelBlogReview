import 'package:flutter/material.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/auth/widget/auth_field.dart';
import 'package:travelblog/features/pages/writeblog/widget/Dropdown_Component.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlogCreate extends StatefulWidget {
  const BlogCreate({super.key});
  @override
  State<BlogCreate> createState() => _BlogCreateState();
}

class _BlogCreateState extends State<BlogCreate> {
  final location = TextEditingController();
  final content = TextEditingController();
  
  @override
  void dispose() {
    super.dispose();
    location.dispose();
    content.dispose();
  }

  List<String> travelTypes = [
    'Ẩm Thực',
    'Tham quan',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 200,
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          background: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
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
                          CustomDropdown(items: travelTypes, hintText: "Thể loại"),
                        ],
                      )
                    ),
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
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomDropdown(items: travelTypes, hintText: "Map"),
                      ],
                    )),
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
                            items: travelTypes, hintText: "Tỉnh/Thành"),
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
                            items: travelTypes, hintText: "Quận/Huyện"),
                      ],
                    )),
                  ),
                  
                ],
              ),
              SizedBox(height: 10,),
              Container(
                    width: 360,
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(115, 115, 115, 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.perm_media,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Thêm đa phương tiện",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                            )
                        ],
                      )
                    ),
                  ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 30, top: 20,right: 30),
              child: Column(
                children: [
                  AuthField(controller: location, hintText: "Địa chỉ ...", ishiddenText: false,),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(      
                        borderRadius: BorderRadius.circular(5)
                      ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText:
                            "Nội dung bài viết ...",
                        hintStyle: TextStyle(
                            color: PJcolor.primaryColor2,
                            fontSize: 20,
                            fontFamily: "noto",
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible),
                        border: InputBorder.none
                      )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    
      bottomSheet: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 0.25,
                blurRadius: 3,
                offset: Offset(0,2),
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){},
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width-100,
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
                      color: Colors.white
                    ),
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
