
part of 'user_buttons_bloc.dart';

enum Acceptable{
  ACCEPT, DECLINE
}

class UserButtonsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class BlockUserEvent extends UserButtonsEvent{}
class UnblockUserEvent extends UserButtonsEvent{}
class SendRequestFriendEvent extends UserButtonsEvent{}
class CancelRequestFriendEvent extends UserButtonsEvent{}
class CancelFriendEvent extends UserButtonsEvent{}
// ignore: must_be_immutable
class AcceptRequestFriendEvent extends UserButtonsEvent{
  Acceptable code;
  AcceptRequestFriendEvent({required this.code});
}
class InitButtonsEvent extends UserButtonsEvent{}
class UpdateButtonsEvent extends UserButtonsEvent{}
