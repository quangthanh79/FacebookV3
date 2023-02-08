// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String? user_id;
  final String? avatarUrl;
  final String postId;
  final String userName;
  final String time;
  final int date;
  final String content;
  final int likesNumber;
  final int commentsNumber;
  final bool isSelfLiking;
  final String? assetType;
  final List<String>? assetContentUrl;
  const Post({
    this.user_id,
    this.avatarUrl,
    required this.postId,
    required this.userName,
    required this.time,
    required this.date,
    this.content = '',
    required this.likesNumber,
    required this.commentsNumber,
    required this.isSelfLiking,
    this.assetType,
    this.assetContentUrl,
  });

  @override
  List<Object?> get props => [
        userName,
        user_id,
        assetContentUrl,
        assetType,
        avatarUrl,
        time,
        postId,
        likesNumber,
        isSelfLiking,
        commentsNumber,
        content,
        date
      ];

  @override
  bool get stringify => true;

  Post copyWith({
    String? user_id,
    String? avatarUrl,
    String? postId,
    String? userName,
    String? time,
    int? date,
    String? content,
    int? likesNumber,
    int? commentsNumber,
    bool? isSelfLiking,
    String? assetType,
    List<String>? assetContentUrl,
  }) {
    return Post(
      user_id: user_id ?? this.user_id,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      postId: postId ?? this.postId,
      userName: userName ?? this.userName,
      time: time ?? this.time,
      date: date ?? this.date,
      content: content ?? this.content,
      likesNumber: likesNumber ?? this.likesNumber,
      commentsNumber: commentsNumber ?? this.commentsNumber,
      isSelfLiking: isSelfLiking ?? this.isSelfLiking,
      assetType: assetType ?? this.assetType,
      assetContentUrl: assetContentUrl ?? this.assetContentUrl,
    );
  }
}
