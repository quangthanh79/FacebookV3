// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facebook_auth/utils/constant.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../core/helper/make_time.dart';
import '../../screen/home_screen/model/comment.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentModel {
  final String id;
  final String? comment;
  final Poster? poster;
  final String created;
  CommentModel({
    required this.id,
    this.comment,
    this.poster,
    required this.created,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}

extension CommentModelX on CommentModel {
  Comment toEntity() {
    return Comment(
        user_id: poster?.id,
        content: comment ?? '',
        userName: poster?.userName ?? '',
        time: toTime(
            DateTime.now().millisecondsSinceEpoch ~/ 1000 - int.parse(created)),
        avatarUrl: poster != null
            ? (poster!.avatarUrl ?? defaultAvatar)
            : defaultAvatar);
  }
}

@JsonSerializable()
class Poster {
  final String id;
  @JsonKey(name: 'name')
  final String? userName;
  @JsonKey(name: 'avatar')
  final String? avatarUrl;
  Poster({
    required this.id,
    this.userName,
    this.avatarUrl,
  });
  factory Poster.fromJson(Map<String, dynamic> json) => _$PosterFromJson(json);
  Map<String, dynamic> toJson() => _$PosterToJson(this);
}
