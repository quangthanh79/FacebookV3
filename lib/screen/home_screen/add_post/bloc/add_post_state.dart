// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_post_bloc.dart';

enum AddPostStatus { initial, posting, success, failure }

class AddPostState extends Equatable {
  final AddPostStatus status;
  final String content;
  final String? error;
  final File? image;
  final Post? post;
  const AddPostState({
    this.status = AddPostStatus.initial,
    this.content = '',
    this.error,
    this.image,
    this.post,
  });

  @override
  List<Object?> get props => [content, status, error, image];

  AddPostState copyWith({
    AddPostStatus? status,
    String? content,
    String? error,
    File? image,
    Post? post,
  }) {
    return AddPostState(
      status: status ?? this.status,
      content: content ?? this.content,
      error: error ?? this.error,
      image: image ?? this.image,
      post: post ?? this.post,
    );
  }
}
