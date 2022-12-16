

enum FriendItemStatus {
  ME, IS_FRIEND, NOT_FRIEND, REQUESTING, REQUESTED, INITIAL
}

class FriendItemState{
  FriendItemStatus status;
  FriendItemState({required this.status});
}