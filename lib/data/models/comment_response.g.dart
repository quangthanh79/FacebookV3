// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as String,
      comment: json['comment'] as String?,
      poster: json['poster'] == null
          ? null
          : Poster.fromJson(json['poster'] as Map<String, dynamic>),
      created: json['created'] as String,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'poster': instance.poster,
      'created': instance.created,
    };

Poster _$PosterFromJson(Map<String, dynamic> json) => Poster(
      id: json['id'] as String,
      userName: json['name'] as String?,
      avatarUrl: json['avatar'] as String?,
    );

Map<String, dynamic> _$PosterToJson(Poster instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.userName,
      'avatar': instance.avatarUrl,
    };
