import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:travelblog/color/color.dart";
import "package:travelblog/features/pages/showblogdetail/widget/comment_list.dart";

class ShowDetail extends StatefulWidget {
  const ShowDetail({super.key});

  @override
  State<ShowDetail> createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: Image.network("https://ca.slack-edge.com/T02QFU9TCTD-U064XJS8UGH-3b52a500b766-512").image,
                      radius: 25,
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text(
                              "Sun Slave",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: "noto"),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "@vuachichcho",
                              style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: "noto"),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          "13:00",
                          style: TextStyle(color: Colors.grey, fontFamily: "noto"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trải nghiệm du lịch tại quần đảo Cô Tô 3 ngày 2 đêm",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "noto",
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Cô Tô đã không còn là một địa điểm du lịch xa lạ với các bạn trẻ ưa khám phá. Cô Tô mang một nét đẹp hoang sơ, bình dị và an yên. Team iVIVU đã thực hiện một chuyến hành trình trải nghiệm và bất ngờ trước những vẻ đẹp của Cô Tô. Cùng ngắm nhìn những hình ảnh tại Cô Tô mà team iVIVU đã ghi lại được nhé.",
                    maxLines: 20,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: "noto",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      
                    ),
                  ),
                ),
                Text(
                  "Địa chỉ: Đảo Cô Tô, Quảng Ninh",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: "noto",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Image(
                    image: NetworkImage("https://cdn3.ivivu.com/2022/07/%C4%91%E1%BA%A3o-c%C3%B4-t%C3%B4-ivivu1.jpg"
                    )
                  ),
                ),
                SizedBox(height: 20,),
                Divider(
                color: PJcolor.primaryColor,
                thickness: 2,
              ),Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                    children: [
                      Icon(Icons.thumb_up),
                      SizedBox(width: 5),
                      Text('100'),
                    ],
                    ),
                    Row(
                    children: [
                      Icon(Icons.comment),
                      SizedBox(width: 5),
                      Text('100'),
                    ],
                    ),
                   
                  ],
                ),  
                SizedBox(height: 20),
                Text(
                  "Bình luận của bài viết:",
                  style: TextStyle(
                    fontFamily: "noto",
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10,),
                CommentList(),
              ],
            ),
        )
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
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: PJcolor.buttonColor,
                ),
                child: Center(
                  child: Text(
                    'Bình luận dưới tên Sun Slave',
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
