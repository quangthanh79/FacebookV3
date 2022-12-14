class ResponseListConversation {
  String? code;
  String? message;
  List<Conversation>? data;
  int? numNewMessage;

  ResponseListConversation({this.code, this.message, this.data, this.numNewMessage});

  ResponseListConversation.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Conversation>[];
      json['data'].forEach((v) {
        data!.add(new Conversation.fromJson(v));
      });
    }
    numNewMessage = json['numNewMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['numNewMessage'] = this.numNewMessage;
    return data;
  }
}

class Conversation {
  int? id;
  Partner? partner;
  LastMessage? lastMessage;

  Conversation({this.id, this.partner, this.lastMessage});

  Conversation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partner =
    json['partner'] != null ? new Partner.fromJson(json['partner']) : null;
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.partner != null) {
      data['partner'] = this.partner!.toJson();
    }
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    return data;
  }
}

class Partner {
  String? id;
  String? username;
  String? avatar;

  Partner({this.id, this.username, this.avatar});

  Partner.fromJson(Map<String, dynamic> json) {
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

class LastMessage {
  String? created;
  String? message;
  String? senderId;
  String? unread;

  LastMessage({this.created, this.message, this.senderId, this.unread});

  LastMessage.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    message = json['message'];
    senderId = json['senderId'];
    unread = json['unread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created'] = this.created;
    data['message'] = this.message;
    data['senderId'] = this.senderId;
    data['unread'] = this.unread;
    return data;
  }
}