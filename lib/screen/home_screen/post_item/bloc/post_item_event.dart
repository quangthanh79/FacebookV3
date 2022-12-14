// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_item_bloc.dart';

abstract class PostItemEvent extends Equatable {
  const PostItemEvent();

  @override
  List<Object> get props => [];
}

class PostInitEvent extends PostItemEvent {
  final bool isSelfLiking;
  const PostInitEvent({
    required this.isSelfLiking,
  });
  @override
  List<Object> get props => [isSelfLiking];
}

class LikeClickEvent extends PostItemEvent {}
