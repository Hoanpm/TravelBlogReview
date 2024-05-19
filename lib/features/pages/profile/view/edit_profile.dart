import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelblog/color/color.dart';
import 'package:travelblog/features/auth/widget/auth_field.dart';
import 'package:travelblog/features/pages/profile/view/user_profile_view.dart';
import 'package:travelblog/provider/supabase_manager.dart';

final supabase = Supabase.instance.client;

class EditProfileView extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const EditProfileView());
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  SupabaseManager supabaseManager = SupabaseManager();
  final username = TextEditingController();
  final fullName = TextEditingController();
  Map<String, dynamic> user = {
    'image_link': '',
    'username': '',
    'fullName': ''
  };
  String? _imageUrl = "";

  getUserInfo() async {
    var userInfo =
        await supabaseManager.getUserInfo(supabase.auth.currentUser?.id);
    setState(() {
      user = userInfo[0];
      fullName.text = user['fullName'];
      username.text = user['username'];
    });
  }

  Future<void> updateUserInfor() async {
    await supabase.from('users').update({
      'fullName': fullName.text,
      'username': username.text,
      'image_link': _imageUrl != "" ? _imageUrl : user['image_link']
    }).eq('id', user['id']);

    if (!context.mounted) return;
    Navigator.pop(context, true); 
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Chỉnh sửa thông tin cá nhân",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.25,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: user['image_link'] != ''
                      ? _imageUrl == ""
                          ? Image.network(
                              user['image_link'],
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              _imageUrl!,
                              fit: BoxFit.cover,
                            )
                      : Container(),
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
                      final imageExtension =
                          image.path.split('.').last.toLowerCase();
                      final imageBytes = await image.readAsBytes();
                      final imagePath = '/$userId/user_avatar';
                      await supabase.storage.from('postImages').uploadBinary(
                          imagePath, imageBytes,
                          fileOptions: FileOptions(
                              upsert: true,
                              contentType: 'image/$imageExtension'));
                      String imageUrl = supabase.storage
                          .from('postImages')
                          .getPublicUrl(imagePath);
                      imageUrl = Uri.parse(imageUrl).replace(queryParameters: {
                        't': DateTime.now().millisecondsSinceEpoch.toString()
                      }).toString();
                      setState(() {
                        _imageUrl = imageUrl;
                      });
                    },
                    child: Center(
                      child: Text("Upload"),
                    )),
                SizedBox(
                  height: 30,
                ),
                AuthField(
                    controller: fullName,
                    hintText: "Fullname",
                    ishiddenText: false),
                AuthField(
                    controller: username,
                    hintText: "Username",
                    ishiddenText: false),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 40),
                        backgroundColor: PJcolor.buttonColor,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      if (_imageUrl == "" &&
                          fullName.text == user['fullName'] &&
                          username.text == user['username']) {
                        Navigator.pop(context, true); 
                      } else {
                        updateUserInfor();
                      }
                    },
                    child: Center(
                      child: Text("Lưu thay đổi"),
                    )),
              ],
            ),
          ),
        ));
  }
}
