import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  @JsonKey(name: 'code')
  String? statusCode;

  @JsonKey(name: 'message')
  String? messages;

  @JsonKey(name: 'data')
  T? data;

  ApiResponse({this.statusCode, this.messages, this.data});

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(T Function(Object? json) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}
