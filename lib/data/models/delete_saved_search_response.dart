

class DeleteSavedSearchResponse {
  String? code;
  String? message;
  String? data;

  DeleteSavedSearchResponse({this.code, this.message, this.data});

  DeleteSavedSearchResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}