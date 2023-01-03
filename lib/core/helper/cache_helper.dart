import 'dart:convert';

import 'package:facebook_auth/data/models/post_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  //key
  static const String listPost = 'list_post';
  //instance
  final SharedPreferences _sharedPreferences;

  // constructor
  CacheHelper(this._sharedPreferences);

  Future<bool> setListPost(PostListResponse item) {
    return _sharedPreferences.setString(listPost, json.encode(item.toMap()));
  }

  String get getListPost {
    return _sharedPreferences.getString(listPost) ?? '';
  }
}
