import 'package:json_annotation/json_annotation.dart';

part 'server_message_response.g.dart';

@JsonSerializable()
class ServerMessageResponse {
  String? code;
  String? message;

  ServerMessageResponse({
    this.code,
    this.message,
  });

  factory ServerMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ServerMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServerMessageResponseToJson(this);
}
