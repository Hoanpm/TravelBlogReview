import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.file(File("/data/user/0/com.example.travelblog/cache/d863718f-46a1-424f-92e5-fa6ca4d3a521/1000000915.jpg")),
        ElevatedButton(
            onPressed: () => {_pickImageFromGallery()},
            child: Center(
              child: Text("Pick image from Galery"),
            )),
        ElevatedButton(
            onPressed: () => {},
            child: Center(
              child: Text("Pick image from Camera"),
            )),
        SizedBox(
          height: 20,
        ),
        _selectedImage != null
            ? Image.file(_selectedImage!)
            : Text("Please select an image!")
      ],
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      print(returnedImage.path);
      _selectedImage = File(returnedImage.path);
    });
  }
}
