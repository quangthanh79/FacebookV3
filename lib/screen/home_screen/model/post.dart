// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:facebook_auth/utils/constant.dart';

class Post extends Equatable {
  final String? user_id;
  final String? avatarUrl;
  final String postId;
  final String userName;
  final String time;
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
    this.content = '',
    required this.likesNumber,
    required this.commentsNumber,
    required this.isSelfLiking,
    this.assetType,
    this.assetContentUrl,
  });

  static Post get fakeData => const Post(
      postId: '',
      userName: 'SonNN',
      time: '40 minutes ago',
      content:
          'Trong bối cảnh hiện nay, khi công nghệ thông tin càng ngày càng phát triển và có tầm ảnh hưởng sâu rộng đến đời sống kinh tế - xã hội của từng quốc gia, khu vực, các trang mạng xã hội trở thành các phương tiện để các thế lực thù địch lợi dụng để tuyên truyền chống phá Đảng, phá hoại thành quả của cách mạng. Trước thực tiễn đó, Bộ Chính trị đã ra Nghị quyết số 35-NQ/TW “về tăng cường bảo vệ nền tảng tư tưởng của Đảng, đấu tranh phản bác các quan điểm sai trái, thù địch trong tình hình mới”. Quán triệt tinh thần của Nghị quyết, xin giới thiệu tác phẩm: Tuyên ngôn của Đảng Cộng sản, tác phẩm đánh dấu sự ra đời của chủ nghĩa Mác – Lênin. Qua tác phẩm, chúng ta hiểu hơn về nền tảng tư tưởng của Đảng, nâng cao tinh thần trách nhiệm với sự nghiệp xây dựng xã hội chủ nghĩa trong giai đoạn hiện nay.',
      likesNumber: 2331,
      commentsNumber: 1235,
      isSelfLiking: true,
      assetType: TYPE_IMAGE,
      assetContentUrl: ['assets/images/example_post_image.jfif']);

  Post copyWith({
    String? user_id,
    String? avatarUrl,
    String? postId,
    String? userName,
    String? time,
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
      content: content ?? this.content,
      likesNumber: likesNumber ?? this.likesNumber,
      commentsNumber: commentsNumber ?? this.commentsNumber,
      isSelfLiking: isSelfLiking ?? this.isSelfLiking,
      assetType: assetType ?? this.assetType,
      assetContentUrl: assetContentUrl ?? this.assetContentUrl,
    );
  }

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
        content
      ];

  @override
  bool get stringify => true;
}
