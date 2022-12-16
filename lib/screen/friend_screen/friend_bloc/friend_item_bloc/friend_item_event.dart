

class FriendItemEvent{

}

enum Acceptable{
  ACCEPT, DECLINE
}

class SendRequestEvent extends FriendItemEvent{}
class CancelRequestEvent extends FriendItemEvent{}
class CancelFriendEvent extends FriendItemEvent{}
// ignore: must_be_immutable
class AcceptRequestEvent extends FriendItemEvent{
  Acceptable code;
  AcceptRequestEvent({required this.code});
}
class InitButtonsEvent extends FriendItemEvent{}
class UpdateButtonsEvent extends FriendItemEvent{}

