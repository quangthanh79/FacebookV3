// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_post_bloc.dart';

enum AddPostStatus { initial, posting, success, failure }

enum AddPostType { none, image, video }

class AddPostState extends Equatable {
  final AddPostStatus status;
  final String content;
  final String? error;
  final List<File>? images;
  final File? video;
  final Post? post;
  final AddPostType addPostType;
  final bool isEditing;
  const AddPostState({
    this.status = AddPostStatus.initial,
    this.content = '',
    this.error,
    this.images,
    this.video,
    this.post,
    this.addPostType = AddPostType.none,
    this.isEditing = false,
  });

  @override
  List<Object?> get props =>
      [content, status, error, images, addPostType, video];

  AddPostState copyWith({
    AddPostStatus? status,
    String? content,
    String? error,
    List<File>? images,
    File? video,
    Post? post,
    AddPostType? addPostType,
    bool? isEditing,
  }) {
    return AddPostState(
      status: status ?? this.status,
      content: content ?? this.content,
      error: error ?? this.error,
      images: images ?? this.images,
      video: video ?? this.video,
      post: post ?? this.post,
      addPostType: addPostType ?? this.addPostType,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
