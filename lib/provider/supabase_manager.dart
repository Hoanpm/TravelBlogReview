import 'dart:ffi';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  Future getCityList() async {
    try {
      final cityList = await Supabase.instance.client.from('city').select();
      return cityList;
    } catch (error) {
      print(error);
    }
  }

  Future getDistrictList(int cityId) async {
    try {
      final districtList = await Supabase.instance.client
          .from('district')
          .select()
          .eq("city_id", cityId);
      return districtList;
    } catch (error) {
      print(error);
    }
  }

  Future getPostList() async {
    try {
      final postList = await Supabase.instance.client.from('post').select();
      return postList;
    } catch (error) {
      print(error);
    }
  }

  Future getUserInfo(String userId) async {
    try {
      final user = await Supabase.instance.client
          .from('users')
          .select()
          .eq('id', userId);
      return user;
    } catch (error) {
      print(error);
    }
  }
}
