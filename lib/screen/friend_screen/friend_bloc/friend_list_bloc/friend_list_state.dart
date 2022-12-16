

import 'package:equatable/equatable.dart';

enum FriendListStatus{
  LOADING, NO_FRIENDS, LOADED
}

// ignore: must_be_immutable
class FriendListState{
  FriendListStatus status;
  FriendListState({required this.status});
}

