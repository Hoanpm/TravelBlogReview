import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:intl/intl.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:travelblog/color/color.dart";
import "package:travelblog/features/auth/widget/custom_alert_box.dart";
import "package:travelblog/features/pages/showblogdetail/widget/comment_list.dart";
import "package:travelblog/provider/supabase_manager.dart";

final supabase = Supabase.instance.client;

class ShowDetail extends StatefulWidget {
  final Map<String, dynamic> post;
  static route() => MaterialPageRoute(
      builder: (context) => const ShowDetail(
            post: {},
          ));
  const ShowDetail({super.key, required this.post});

  @override
  State<ShowDetail> createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  SupabaseManager supabaseManager = SupabaseManager();
  final commentText = TextEditingController(text: "");
  Map<String, dynamic> user = {'fullName': ""};
  int likeNumb = 0;
  int cmtNumb = 0;
  bool isLiked = false;
  List<Map<String, dynamic>> cmtList = [];

  getUserInfo() async {
    final useri4 =
        await supabaseManager.getUserInfo(supabase.auth.currentUser!.id);
    setState(() {
      user = useri4[0];
    });
  }

  getPostCommentList() async {
    final commentList =
        await supabaseManager.getPostCommentList(widget.post['id']);
    setState(() {
      cmtList = commentList.reversed.toList();
    });
  }

  getPostCommentNumber() async {
    final commentNumber =
        await supabaseManager.getPostCommentNumber(widget.post['id']);
    setState(() {
      cmtNumb = commentNumber.count;
    });
  }

  getPostLikeNumber() async {
    final likeNumber =
        await supabaseManager.getPostLikeNumber(widget.post['id']);
    setState(() {
      likeNumb = likeNumber.count;
    });
  }

  checkLiked() async {
    final liked = await supabaseManager.checkUserLiked(
        supabase.auth.currentUser?.id, widget.post['id']);
    setState(() {
      isLiked = liked;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostLikeNumber();
    if (supabase.auth.currentUser != null) {
      checkLiked();
      getUserInfo();
    }
    getPostCommentList();
    getPostCommentNumber();
  }

  Future<void> handleLikePost() async {
    try {
      await supabase.from('like').insert({
        'user_id': supabase.auth.currentUser?.id,
        'post_id': widget.post['id']
      });

      setState(() {
        isLiked = true;
        getPostLikeNumber();
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleDislikePost() async {
    try {
      await supabase
          .from('like')
          .delete()
          .eq('user_id', supabase.auth.currentUser!.id)
          .eq('post_id', widget.post['id']);

      setState(() {
        isLiked = false;
        getPostLikeNumber();
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleUpdatePostLike() async {
    try {
      await supabase
          .from('post')
          .update({'like': likeNumb, 'comment_numb': cmtNumb}).eq(
              'id', widget.post['id']);
      Navigator.pop(context, true);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            handleUpdatePostLike();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        toolbarHeight: 60,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            padding: EdgeInsets.only(left: 40, top: 16),
            child: Column(
              children: [
                SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.post['user_image_link']),
                      radius: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.post['user_fullName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: "noto"),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "@${widget.post['user_username']}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontFamily: "noto"),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(widget.post['created_at'])),
                          style:
                              TextStyle(color: Colors.grey, fontFamily: "noto"),
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
              widget.post['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: "noto",
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.post['content'],
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
              "Địa chỉ: ${widget.post['detail_location']}",
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
              child: Image(image: NetworkImage(widget.post['image_link'])),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: PJcolor.primaryColor,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (supabase.auth.currentUser == null) {
                          var dialog = const CustomAlertDialog(
                              title: "Notice",
                              message:
                                  "Bạn cần đăng nhập để sử dụng chức năng này !");
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => dialog);
                        } else {
                          isLiked ? handleDislikePost() : handleLikePost();
                        }
                      },
                      child: Icon(
                        Icons.thumb_up,
                        color: isLiked ? PJcolor.buttonColor : Colors.black,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(likeNumb.toString()),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.comment),
                    SizedBox(width: 5),
                    Text(cmtNumb.toString()),
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
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            CommentList(
              cmtList: cmtList,
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      )),
      bottomSheet: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 0.25,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                )
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: 40,
                    decoration: BoxDecoration(
                      color: PJcolor.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: commentText,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                          hintText: user['fullName'] != "" ? 'Bình luận dưới tên ${user['fullName']}' : "Bình luận ...",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: PJcolor.primaryColor2,
                          )),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            fixedSize: const Size(40, 40),
                            backgroundColor: PJcolor.buttonColor,
                            foregroundColor: Colors.white),
                        onPressed: () async {
                          if (supabase.auth.currentUser == null) {
                            var dialog = const CustomAlertDialog(
                              title: "Notice",
                              message:
                                  "Bạn cần đăng nhập để sử dụng chức năng này !");
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => dialog);
                          } else {
                            if (commentText.text != "") {
                              await supabase.from('comment').insert({
                                'user_id': user['id'],
                                'post_id': widget.post['id'],
                                'content': commentText.text
                              });

                              setState(() {
                                getPostCommentList();
                                getPostCommentNumber();
                                commentText.text = "";
                              });
                            }
                          }
                        },
                        child: Icon(
                          Icons.send,
                          size: 20,
                        )),
                  )
                ],
              ),
            ),
    );
  }
}
