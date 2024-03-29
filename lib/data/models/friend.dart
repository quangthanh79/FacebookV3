
import 'package:facebook_auth/data/models/user_info.dart';

class ResponseListFriend extends Response{
  ListFriend? data;

  ResponseListFriend({super.code, super.message, this.data, super.details});

  ResponseListFriend.fromJson(Map<String, dynamic> json) {
    copyFrom(Response.fromJson(json));
    data = json['data'] != null ? ListFriend.fromJson(json['data']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ResponseActionFriend extends Response{

  ResponseActionFriend({super.code, super.message, super.details});

  ResponseActionFriend.fromJson(Map<String, dynamic> json) {
    copyFrom(Response.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}

class Friend {
  String? user_id;
  String? username;
  String? avatar;
  int? same_friends;
  int? created;
  String? is_friend;

  Friend(
      {this.user_id, this.username, this.same_friends, this.avatar, this.created, this.is_friend});

  Friend.fromJson(Map<String, dynamic> json) {
    user_id = json.containsKey('user_id') ? json['user_id'] : json['id'];
    username = json['username'];
    created = json['created'] != null ? int.parse(json['created']) : 0;
    avatar = json['avatar'];
    same_friends = json['same_friends'] != null ? int.parse(json['same_friends']) : 0;
    is_friend = json['is_friend'];
    // ignore: prefer_interpolation_to_compose_strings
    // print("Debug: " + json["user_id"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user_id;
    data['username'] = username;
    data['same_friends'] = same_friends;
    data['avatar'] = avatar;
    data['created'] = created;
    data['is_friend'] = is_friend;
    return data;
  }

  void copyFrom(Friend friend){
    user_id = friend.user_id;
    username = friend.username;
    avatar = friend.avatar;
    same_friends = friend.same_friends;
    created = friend.created;
    is_friend = friend.is_friend;
  }
}



class ListFriend{
  late List<Friend> list;
  late int total;

  ListFriend(){
    list = [];
    total = 0;
  }

  ListFriend.fromJson(Map<String, dynamic> json) {
    String key = "list_users";
    if (json.containsKey("friends")){
      key = "friends";
    } else if (json.containsKey("list_users")){
      key = "list_users";
    } else if (json.containsKey('request')){
      key = "request";
    }
    if (json[key] != null) {
      list = <Friend>[];
      json[key].forEach((v) {
        list.add(Friend.fromJson(v));
      });
    }
    total = json['total'] != null ? int.parse(json['total']) : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['friends'] = list.map((v) => v.toJson()).toList();
    data['total'] = total;
    return data;
  }

  void copyFrom(ListFriend listFriend){
    list = listFriend.list;
    total = listFriend.total;
  }

  int get length => list.length;
  bool get isEmpty => list.isEmpty;

  void clear(){
    list.clear();
  }

  void append(ListFriend listFriend){
    list.addAll(listFriend.list);
  }

  void appendList(List<Friend> listFriend){
    list.addAll(listFriend);
  }
}


