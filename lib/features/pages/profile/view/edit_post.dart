import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/auth/widget/auth_field.dart';

final supabase = Supabase.instance.client;

class EditPostView extends StatefulWidget {
  final Map<String, dynamic> post;
  static route() => MaterialPageRoute(
      builder: (context) => const EditPostView(
            post: {},
          ));
  const EditPostView({super.key, required this.post});

  @override
  State<EditPostView> createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {
  late TextEditingController title;
  late TextEditingController location;
  late TextEditingController content;
  String? _imageUrl = "";

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.post['title']);
    location = TextEditingController(text: widget.post['detail_location']);
    content = TextEditingController(text: widget.post['content']);
  }

  @override
  void dispose() {
    title.dispose();
    location.dispose();
    content.dispose();
    super.dispose();
  }

  Future<void> updateUserPost() async {
    await supabase.from('post').update({
      'title': title.text,
      'detail_location': location.text,
      'content': content.text,
      'image_link': _imageUrl != "" ? _imageUrl : widget.post['image_link']
    }).eq('id', widget.post['id']);

    if (!context.mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chỉnh sửa bài viết",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _imageUrl == ""
                  ? Image.network(
                      widget.post['image_link'],
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      _imageUrl!,
                      fit: BoxFit.cover,
                    ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 40),
                      backgroundColor: Color.fromRGBO(115, 115, 115, 1),
                      foregroundColor: Colors.white),
                  onPressed: () async {
                    final userId = supabase.auth.currentUser!.id;
                    final ImagePicker picker = ImagePicker();
                    XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image == null) {
                      return;
                    }
                    DateTime now = DateTime.now();

                    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                    String formatted = formatter.format(now);
                    final imageExtension =
                        image.path.split('.').last.toLowerCase();
                    final imageBytes = await image.readAsBytes();
                    final imagePath = '/$userId/$formatted';
                    await supabase.storage.from('postImages').uploadBinary(
                        imagePath, imageBytes,
                        fileOptions:
                            FileOptions(contentType: 'image/$imageExtension'));
                    final imageUrl = supabase.storage
                        .from('postImages')
                        .getPublicUrl(imagePath);
                    setState(() {
                      _imageUrl = imageUrl;
                    });
                  },
                  child: Center(
                    child: Text("Upload"),
                  )),
              AuthField(
                  controller: title, hintText: "Tiêu đề", ishiddenText: false),
              AuthField(
                  controller: location,
                  hintText: "Địa chỉ",
                  ishiddenText: false),
              Container(
                height: 150,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
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
              SizedBox(
                height: 70,
              )
            ],
          ),
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
                if (title.text == widget.post['title'] &&
                    location.text == widget.post['detail_location'] &&
                    content.text == widget.post['content'] &&
                    _imageUrl == "") {
                  Navigator.pop(context, true);
                } else {
                  updateUserPost();
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
                    'Lưu thông tin bài viết',
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
