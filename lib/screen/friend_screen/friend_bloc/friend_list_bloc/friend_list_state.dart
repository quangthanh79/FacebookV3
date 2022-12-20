

part of 'friend_list_bloc.dart';

enum FriendListStatus{
  LOADING, NO_FRIENDS, LOADED
}

// ignore: must_be_immutable
class FriendListState{
  FriendListStatus status;
  FriendListState({required this.status});
}

