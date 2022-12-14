class ResponseChatDetail {
  String? code;
  String? message;
  int? indexMessageLast;
  List<MessageDetail>? data;

  ResponseChatDetail({this.code, this.message, this.indexMessageLast, this.data});

  ResponseChatDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    indexMessageLast = json['indexMessageLast'];
    if (json['data'] != null) {
      data = <MessageDetail>[];
      json['data'].forEach((v) {
        data!.add(new MessageDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['indexMessageLast'] = this.indexMessageLast;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageDetail {
  String? message;
  int? messageId;
  String? unread;
  String? created;
  Sender? sender;

  MessageDetail({this.message, this.messageId, this.unread, this.created, this.sender});

  MessageDetail.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageId = json['message_id'];
    unread = json['unread'];
    created = json['created'];
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['message_id'] = this.messageId;
    data['unread'] = this.unread;
    data['created'] = this.created;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    return data;
  }
}

class Sender {
  String? id;
  String? username;
  String? avatar;

  Sender({this.id, this.username,this.avatar});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    return data;
  }
}