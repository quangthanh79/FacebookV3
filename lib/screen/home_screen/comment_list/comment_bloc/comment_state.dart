// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comment_bloc.dart';

enum CommentStatus {
  initial,
  loading,
  loadedSuccess,
  loadedFailure,
}

class CommentState extends Equatable {
  final CommentStatus status;
  final String? error;
  final List<Comment> itemList;
  final String? addCommentContent;
  final Comment? newComment;

  const CommentState(
      {this.status = CommentStatus.initial,
      this.error,
      this.itemList = const [],
      this.addCommentContent,
      this.newComment});

  @override
  List<Object?> get props =>
      [status, itemList, error, addCommentContent, newComment];

  CommentState copyWith(
      {CommentStatus? status,
      List<Comment>? itemList,
      String? error,
      String? addCommentContent,
      Comment? newComment}) {
    return CommentState(
        status: status ?? this.status,
        itemList: itemList ?? this.itemList,
        error: error ?? this.error,
        addCommentContent: addCommentContent ?? '',
        newComment: newComment ?? this.newComment);
  }
}
