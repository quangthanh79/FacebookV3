// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class LoadCommentEvent extends CommentEvent {
  final String postId;
  const LoadCommentEvent({
    required this.postId,
  });
  @override
  List<Object> get props => [postId];
}

class AddComment extends CommentEvent {
  final String postId;
  final String content;
  const AddComment({
    required this.postId,
    required this.content,
  });
  @override
  List<Object> get props => [postId];
}
