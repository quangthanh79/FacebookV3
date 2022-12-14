

class ResponseUserFriendsChat {
  String? code;
  String? message;
  Data? data;

  ResponseUserFriendsChat({this.code, this.message, this.data});

  ResponseUserFriendsChat.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Friends>? friends;
  String? total;

  Data({this.friends, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['friends'] != null) {
      friends = <Friends>[];
      json['friends'].forEach((v) {
        friends!.add(new Friends.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.friends != null) {
      data['friends'] = this.friends!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Friends {
  String? user_id;
  String? username;
  String? avatar;
  String? sameFriends;
  String? created;

  Friends(
      {this.user_id,
        this.username,
        this.avatar,
        this.sameFriends,
        this.created});

  Friends.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    username = json['username'];
    avatar = json['avatar'];
    sameFriends = json['same_friends'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['same_friends'] = this.sameFriends;
    data['created'] = this.created;
    return data;
  }
}
