

import 'package:facebook_auth/utils/session_user.dart';

class ResponseUser{
  String? code;
  String? message;
  User? data;

  ResponseUser({
    this.code, this.message, this.data
  });

  ResponseUser.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = <String, dynamic>{};
    json['code'] = code;
    json['message'] = message;
    json['data'] = data != null ? data!.toJson() : null;
    return json;
  }


}

class User {
  String? id;
  String? username;
  int created = 0;
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
  String join = "";
  bool isMe = false;

  User({
    this.id, this.username, this.created = 0, this.description,
    this.avatar, this.cover_image, this.link, this.address,
    this.city, this.country, this.listing, this.is_friend, this.online
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
    int month = 0, year = 0;
    int divide = (365.25 * 24 * 3600).floor();
    year = (created / divide).floor();
    month = ((created - divide * year) / 2629800).floor() + 1;
    year += 1970;
    join = "Tháng $month năm $year";
    // print(join);
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
  }
}