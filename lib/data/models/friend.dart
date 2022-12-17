
class ResponseListFriend {
  String? code;
  String? message;
  ListFriend? data;

  ResponseListFriend({this.code, this.message, this.data});

  ResponseListFriend.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? ListFriend.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Friend {
  String? user_id;
  String? username;
  String? avatar;
  int? same_friends;
  int? created;

  Friend(
      {this.user_id, this.username, this.same_friends, this.avatar, this.created});

  Friend.fromJson(Map<String, dynamic> json) {
    user_id = json.containsKey('user_id') ? json['user_id'] : json['id'];
    username = json['username'];
    created = json['created'] != null ? int.parse(json['created']) : 0;
    avatar = json['avatar'];
    same_friends = json['same_friends'] != null ? int.parse(json['same_friends']) : 0;

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
    return data;
  }

}



class ListFriend{
  List<Friend>? list;
  int? total;

  ListFriend({this.list, this.total});

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
        list!.add(Friend.fromJson(v));
      });
    }
    total = json['total'] != null ? int.parse(json['total']) : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['friends'] = list!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }

  void copyFrom(ListFriend listFriend){
    list = listFriend.list;
    total = listFriend.total;
  }
}