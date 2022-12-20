
class ResponseSignIn {
  String? code;
  String? message;
  User? data;

  ResponseSignIn({this.code, this.message, this.data});

  ResponseSignIn.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
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


class User {
  String? id;
  String? username;
  String? token;
  String? avatar;
  Null? active;

  User({this.id, this.username, this.token, this.avatar, this.active});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    token = json['token'];
    avatar = json['avatar'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['token'] = this.token;
    data['avatar'] = this.avatar;
    data['active'] = this.active;
    return data;
  }
}