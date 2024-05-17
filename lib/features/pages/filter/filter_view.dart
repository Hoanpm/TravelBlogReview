import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelblog/provider/supabase_manager.dart';

final supabase = Supabase.instance.client;

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  SupabaseManager supabaseManager = SupabaseManager();

  @override
  void initState() {
    super.initState();
    getCityList();
  }

  getCityList() async {
    var cities = await supabaseManager.getCityList();
    return cities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
