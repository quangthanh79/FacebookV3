// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadListPost extends HomeEvent {
  final String? keyword;
  const LoadListPost({
    this.keyword,
  });
}

class ResetListPost extends HomeEvent {}

class DisposePost extends HomeEvent {
  final BuildContext context;
  const DisposePost({
    required this.context,
  });
  @override
  List<Object> get props => [context];
}

class MakeTypePost extends HomeEvent {
  final PostType type;
  const MakeTypePost({
    required this.type,
  });
  @override
  List<Object> get props => [type];
}
