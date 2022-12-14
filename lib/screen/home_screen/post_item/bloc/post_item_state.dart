// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_item_bloc.dart';

enum PostItemStatus { initial, liked, unLiked }

class PostItemState extends Equatable {
  final PostItemStatus status;
  const PostItemState({
    this.status = PostItemStatus.initial,
  });

  PostItemState copyWith({PostItemStatus? status, Post? model}) {
    return PostItemState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
