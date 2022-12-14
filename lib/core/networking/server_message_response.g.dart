// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerMessageResponse _$ServerMessageResponseFromJson(
        Map<String, dynamic> json) =>
    ServerMessageResponse(
      code: json['code'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ServerMessageResponseToJson(
        ServerMessageResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
