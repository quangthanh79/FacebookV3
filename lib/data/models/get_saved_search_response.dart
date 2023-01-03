

class GetSavedSearchResponse {
  String? code;
  String? message;
  List<ItemSavedSearchModel>? data;

  GetSavedSearchResponse({this.code, this.message, this.data});

  GetSavedSearchResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ItemSavedSearchModel>[];
      json['data'].forEach((v) {
        data!.add(new ItemSavedSearchModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemSavedSearchModel {
  String? id;
  String? keyword;
  String? created;

  ItemSavedSearchModel({this.id, this.keyword, this.created});

  ItemSavedSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyword = json['keyword'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keyword'] = this.keyword;
    data['created'] = this.created;
    return data;
  }
}