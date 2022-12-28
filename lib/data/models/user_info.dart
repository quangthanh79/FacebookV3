

import 'dart:io';

import 'package:facebook_auth/utils/session_user.dart';


class Response{
  String? code;
  String? message;
  String? details;

  Response({
    this.code, this.message, this.details
  });

  Response.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    details = json['details'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = <String, dynamic>{};
    json['code'] = code;
    json['message'] = message;
    if (details != null) json['details'] = details;
    return json;
  }

  void copyFrom(Response? response){
    if (response != null){
      code = response.code;
      message = response.message;
      details = response.details;
    }
  }
}

class ResponseUser extends Response{
  User? data;

  ResponseUser({
    super.code, super.message, this.data, super.details
  });

  ResponseUser.fromJson(Map<String, dynamic> json){
    copyFrom(Response.fromJson(json));
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  @override
  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = super.toJson();
    json['data'] = data != null ? data!.toJson() : null;
    return json;
  }
}

class User {
  String? id;
  String? username;
  int? created;
  String? description;
  String? avatar;
  String? cover_image;
  String? link;
  String? address;
  String? city;
  String? country;
  int? listing;
  String? is_friend;
  int? online;
  int same_friends = 0;
  String join = "";
  bool isMe = false;
  File? avatar_file;
  File? cover_image_file;

  User({
    this.id, this.username, this.created = 0, this.description,
    this.avatar, this.cover_image, this.link, this.address,
    this.city, this.country, this.listing, this.is_friend, this.online,
    this.same_friends = 0
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isMe = id == SessionUser.idUser;
    username = json['username'];
    created = json['created'] != null ? int.parse(json['created']) : 0;
    updateJoinTime();
    description = json['description'];
    avatar = json['avatar'];
    cover_image = json['cover_image'];
    link = json['link'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    listing = json['listing'] != null ? int.parse(json['listing']) : null;
    is_friend = json['is_friend'];
    online = json['online'] != null ? int.parse(json['online']) : null;
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['id'] = id??"";
    data['username'] = username??"";
    data['created'] = "$created";
    data['description'] = description ?? "";
    data['avatar'] = avatar ?? "";
    data['cover_image'] = cover_image ?? "";
    data['link'] = link ?? "";
    data['address'] = address ?? "";
    data['city'] = city ?? "";
    data['country'] = country ?? "";
    data['listing'] = "$listing";
    data['is_friend'] = is_friend ?? "";
    data['online'] = "$online";
    return data;
  }

  void updateJoinTime(){
    if (created != null) {
      int month = 0, year = 0;
      int divide = (365.25 * 24 * 3600).floor();
      year = (created! / divide).floor();
      month = ((created! - divide * year) / 2629800).floor() + 1;
      year += 1970;
      join = "Tháng $month năm $year";
      // print(join);
    } else {
      join = "Tháng 1 năm 1970";
    }
  }

  void copyFrom(User user){
    id = user.id;
    username = user.username;
    created = user.created;
    description = user.description;
    avatar = user.avatar;
    cover_image = user.cover_image;
    link = user.link;
    address = user.address;
    city = user.city;
    country = user.country;
    listing = user.listing;
    is_friend = user.is_friend;
    online = user.online;
    isMe = user.isMe;
    join = user.join;
    avatar_file = user.avatar_file;
    cover_image_file = user.cover_image_file;
  }
}