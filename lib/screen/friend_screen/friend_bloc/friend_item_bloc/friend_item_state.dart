
part of 'friend_item_bloc.dart';

enum FriendItemStatus {
  ME, IS_FRIEND, NOT_FRIEND, REQUESTING, REQUESTED, LOADING, BLOCK
}

class FriendItemState{
  FriendItemStatus status;
  FriendItemState({required this.status});
}