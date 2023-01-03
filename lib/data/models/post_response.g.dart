// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostListResponse _$PostListResponseFromJson(Map<String, dynamic> json) =>
    PostListResponse(
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostListResponseToJson(PostListResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
    };

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
      video: json['video'] == null
          ? null
          : Asset.fromJson(json['video'] as Map<String, dynamic>),
      described: json['described'] as String?,
      like: json['like'] as String?,
      comment: json['comment'] as String?,
      isLiked: json['is_liked'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      created: json['created'] as String?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'video': instance.video,
      'described': instance.described,
      'like': instance.like,
      'comment': instance.comment,
      'is_liked': instance.isLiked,
      'author': instance.author,
      'created': instance.created,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: json['id'] as String?,
      userName: json['username'] as String?,
      avatarUrl: json['avatar'] as String?,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.userName,
      'avatar': instance.avatarUrl,
    };

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      id: json['id'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };

AddPostResponse _$AddPostResponseFromJson(Map<String, dynamic> json) =>
    AddPostResponse(
      id: json['id'] as String?,
      video: json['video'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddPostResponseToJson(AddPostResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'video': instance.video,
      'images': instance.images,
    };
