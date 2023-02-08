// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object?> get props => [];
}

class InitEditPostEvent extends AddPostEvent {
  final List<File>? images;
  final File? video;
  final AddPostType? addPostType;
  final String? content;
  final PostType postType;
  final int editIndex;
  const InitEditPostEvent({
    this.images,
    this.video,
    this.addPostType,
    this.content,
    required this.postType,
    required this.editIndex,
  });
}

class PickImage extends AddPostEvent {
  final List<File>? images;
  const PickImage({
    this.images,
  });

  @override
  List<Object?> get props => [images];

  PickImage copyWith({
    List<File>? images,
  }) {
    return PickImage(
      images: images ?? this.images,
    );
  }
}

class PickVideo extends AddPostEvent {
  final File? video;
  const PickVideo({
    this.video,
  });

  @override
  List<Object?> get props => [video];

  PickVideo copyWith({
    File? video,
    bool? isImage,
  }) {
    return PickVideo(
      video: video ?? this.video,
    );
  }
}

class AddPost extends AddPostEvent {
  final BuildContext context;
  final String? id;
  final int? likesNumber;
  final int? commentsNumber;
  final bool? isSelfLiking;
  const AddPost({
    required this.context,
    this.id,
    this.likesNumber,
    this.commentsNumber,
    this.isSelfLiking,
  });
}

class PostContentChange extends AddPostEvent {
  final String content;
  const PostContentChange({
    required this.content,
  });
  @override
  List<Object> get props => [content];
}
