// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facebook_auth/utils/constant.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:facebook_auth/screen/home_screen/model/post.dart';

import '../../core/helper/make_time.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostListResponse {
  final List<PostModel>? posts;
  PostListResponse({
    this.posts,
  });
  factory PostListResponse.fromJson(Map<String, dynamic> json) =>
      _$PostListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostListResponseToJson(this);
}

@JsonSerializable()
class PostModel {
  final String? id;
  final List<Asset>? image;
  final Asset? video;
  final String? described;
  final String? like;
  final String? comment;
  @JsonKey(name: 'is_liked')
  final String? isLiked;
  final Author? author;
  final String? created;
  PostModel({
    required this.id,
    this.image,
    this.video,
    this.described,
    this.like,
    this.comment,
    this.isLiked,
    this.author,
    this.created,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

extension PostModelX on PostModel {
  Post toEntity() {
    String? assetType;
    if (image != null) {
      assetType = TYPE_IMAGE;
    }
    if (video != null) {
      assetType = TYPE_VIDEO;
    }
    List<String>? assetContentUrl;
    if (image != null) {
      assetContentUrl = (image!.map((e) => e.url!)).toList();
    }
    if (video != null) {
      assetContentUrl = [video!.url!];
    }
    return Post(
        assetType: assetType,
        assetContentUrl: assetContentUrl,
        avatarUrl: author != null ? (author!.avatarUrl) : null,
        postId: id ?? '',
        content: described ?? '',
        user_id: author?.id ?? null,
        userName: author?.userName ?? 'Facebook user',
        time: created != null
            ? toTime(DateTime.now().millisecondsSinceEpoch ~/ 1000 -
                int.parse(created!))
            : '',
        likesNumber: like != null ? int.parse(like!) : 0,
        commentsNumber: comment != null ? int.parse(comment!) : 0,
        isSelfLiking: isLiked == '1');
  }
}

@JsonSerializable()
class Author {
  final String? id;
  @JsonKey(name: 'username')
  final String? userName;
  @JsonKey(name: 'avatar')
  final String? avatarUrl;
  Author({
    this.id,
    this.userName,
    this.avatarUrl,
  });
  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  @override
  String toString() =>
      'Author(id: $id, userName: $userName, avatarUrl: $avatarUrl)';
}

@JsonSerializable()
class Asset {
  final String? id;
  final String? url;
  Asset({
    this.id,
    this.url,
  });
  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
  Map<String, dynamic> toJson() => _$AssetToJson(this);
}

@JsonSerializable()
class AddPostResponse {
  final String? id;
  AddPostResponse({
    this.id,
  });
  factory AddPostResponse.fromJson(Map<String, dynamic> json) =>
      _$AddPostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddPostResponseToJson(this);
}
