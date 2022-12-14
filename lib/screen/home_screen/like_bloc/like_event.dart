// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'like_bloc.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

class AddLikeEvent extends LikeEvent {
  final String postId;
  const AddLikeEvent({
    required this.postId,
  });
  @override
  List<Object> get props => [postId];
}
