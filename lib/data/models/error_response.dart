class ErrorResponse {
  String? code;
  String? message;
  String? details;

  ErrorResponse({this.code, this.message, this.details});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['details'] = this.details;
    return data;
  }
}