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
      final postList = await Supabase.instance.client
          .from('post')
          .select()
          .order('id', ascending: true);
      List<Map<String, dynamic>> newPostList = [];

      for (var post in postList) {
        final userRes = await getUserInfo(post['user_id'] as String);
        var user = userRes[0];
        post['user_image_link'] = user['image_link'];
        post['user_fullName'] = user['fullName'];

        newPostList.add(post);
      }

      return newPostList;
    } catch (error) {
      print(error);
    }
  }

  Future getUserPostList(String? userId) async {
    try {
      final postList = await Supabase.instance.client
          .from('post')
          .select()
          .eq('user_id', userId!)
          .order('id', ascending: true);

      List<Map<String, dynamic>> newPostList = [];

      for (var post in postList) {
        final userRes = await getUserInfo(post['user_id'] as String);
        var user = userRes[0];
        post['user_fullName'] = user['fullName'];
        post['user_image_link'] = user['image_link'];

        newPostList.add(post);
      }

      return newPostList;
    } catch (error) {
      print(error);
    }
  }

  Future getUserInfo(String? userId) async {
    try {
      final user = await Supabase.instance.client
          .from('users')
          .select()
          .eq('id', userId!);

      return user;
    } catch (error) {
      print(error);
    }
  }

  Future getPostBasedOnFilter(int category, int city, int district) async {
    try {
      if (category != 0 && city != 0 && district != 0) {
        final postList = await Supabase.instance.client
            .from('post')
            .select()
            .eq('category_id', category)
            .eq('city_id', city)
            .eq('district_id', district)
            .order('id', ascending: true);

        List<Map<String, dynamic>> newPostList = [];

        for (var post in postList) {
          final userRes = await getUserInfo(post['user_id'] as String);
          var user = userRes[0];
          post['user_image_link'] = user['image_link'];
          post['user_fullName'] = user['fullName'];

          newPostList.add(post);
        }

        return newPostList;
      } else if (category != 0 && city == 0 && district == 0) {
        final postList = await Supabase.instance.client
            .from('post')
            .select()
            .eq('category_id', category)
            .order('id', ascending: true);

        List<Map<String, dynamic>> newPostList = [];

        for (var post in postList) {
          final userRes = await getUserInfo(post['user_id'] as String);
          var user = userRes[0];
          post['user_image_link'] = user['image_link'];
          post['user_fullName'] = user['fullName'];

          newPostList.add(post);
        }

        return newPostList;
      } else if (category != 0 && city != 0 && district == 0) {
        final postList = await Supabase.instance.client
            .from('post')
            .select()
            .eq('category_id', category)
            .eq('city_id', city)
            .order('id', ascending: true);

        List<Map<String, dynamic>> newPostList = [];

        for (var post in postList) {
          final userRes = await getUserInfo(post['user_id'] as String);
          var user = userRes[0];
          post['user_image_link'] = user['image_link'];
          post['user_fullName'] = user['fullName'];

          newPostList.add(post);
        }

        return newPostList;
      } else if (category == 0 && city != 0 && district == 0) {
        final postList = await Supabase.instance.client
            .from('post')
            .select()
            .eq('city_id', city)
            .order('id', ascending: true);

        List<Map<String, dynamic>> newPostList = [];

        for (var post in postList) {
          final userRes = await getUserInfo(post['user_id'] as String);
          var user = userRes[0];
          post['user_image_link'] = user['image_link'];
          post['user_fullName'] = user['fullName'];

          newPostList.add(post);
        }

        return newPostList;
      } else if (category == 0 && city != 0 && district != 0) {
        final postList = await Supabase.instance.client
            .from('post')
            .select()
            .eq('city_id', city)
            .eq('district_id', district)
            .order('id', ascending: true);

        List<Map<String, dynamic>> newPostList = [];

        for (var post in postList) {
          final userRes = await getUserInfo(post['user_id'] as String);
          var user = userRes[0];
          post['user_image_link'] = user['image_link'];
          post['user_fullName'] = user['fullName'];

          newPostList.add(post);
        }

        return newPostList;
      }
    } catch (error) {
      print(error);
    }
  }

  Future getPostBasedOnSearch(String search) async {
    try {
      final newString = search.trim();
      final postList = await Supabase.instance.client
          .from('post')
          .select()
          .ilike('title', '%$newString%')
          .order('id', ascending: true);

      List<Map<String, dynamic>> newPostList = [];

      for (var post in postList) {
        final userRes = await getUserInfo(post['user_id'] as String);
        var user = userRes[0];
        post['user_image_link'] = user['image_link'];
        post['user_fullName'] = user['fullName'];

        newPostList.add(post);
      }

      return newPostList;
    } catch (error) {
      print(error);
    }
  }

  Future getPostSearchedByUser(String? userId, String search) async {
    try {
      var existingSearch = await Supabase.instance.client
          .from('search_history')
          .select()
          .eq('user_id', userId!)
          .eq('searchContent', search);

      if (existingSearch != []) {
         await Supabase.instance.client
          .from('search_history')
          .delete()
          .eq('id', existingSearch[0]['id']);
      }

      var search_history = await Supabase.instance.client
          .from('search_history')
          .select()
          .eq('user_id', userId!);

      if (search_history.length == 5) {
        await Supabase.instance.client
            .from('search_history')
            .delete()
            .eq('id', search_history.first['id']);
      }

      await Supabase.instance.client
          .from('search_history')
          .insert({'user_id': userId, 'searchContent': search});

      final postList = await getPostBasedOnSearch(search);

      return postList;
    } catch (error) {
      print(error);
    }
  }

  Future getuserSearchHistory(String? userId) async {
    try {
      final searchHistoryList = await Supabase.instance.client
          .from('search_history')
          .select()
          .eq('user_id', userId!);

      return searchHistoryList;
    } catch (error) {
      print(error);
    }
  }
}
