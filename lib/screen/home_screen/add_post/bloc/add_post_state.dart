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
  final PostType? postType;
  final int? editIndex;
  const AddPostState({
    this.status = AddPostStatus.initial,
    this.content = '',
    this.error,
    this.images,
    this.video,
    this.post,
    this.addPostType = AddPostType.none,
    this.isEditing = false,
    this.postType,
    this.editIndex,
  });

  @override
  List<Object?> get props =>
      [content, status, error, images, addPostType, video, postType, editIndex];

  AddPostState copyWith({
    AddPostStatus? status,
    String? content,
    String? error,
    List<File>? images,
    File? video,
    Post? post,
    AddPostType? addPostType,
    bool? isEditing,
    PostType? postType,
    int? editIndex,
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
      postType: postType ?? this.postType,
      editIndex: editIndex ?? this.editIndex,
    );
  }
}
