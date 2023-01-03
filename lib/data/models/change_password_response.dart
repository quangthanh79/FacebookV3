

class ChangePasswordResponse {
  String? code;
  String? message;
  String? data;
  String? details;

  ChangePasswordResponse({this.code, this.message, this.data, this.details});

  ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    data['details'] = this.details;
    return data;
  }
}