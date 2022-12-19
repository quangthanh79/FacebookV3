

enum FriendItemStatus {
  ME, IS_FRIEND, NOT_FRIEND, REQUESTING, REQUESTED, LOADING
}

class FriendItemState{
  FriendItemStatus status;
  FriendItemState({required this.status});
}