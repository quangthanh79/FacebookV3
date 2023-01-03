
part of 'user_buttons_bloc.dart';

enum Acceptable{
  ACCEPT, DECLINE
}

// ignore: must_be_immutable
class UserButtonsEvent extends Equatable{
  void Function()? onSuccess;
  void Function()? onError;
  UserButtonsEvent({this.onSuccess, this.onError});
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class BlockUserEvent extends UserButtonsEvent{
  BlockUserEvent({super.onSuccess, super.onError});
}
// ignore: must_be_immutable
class UnblockUserEvent extends UserButtonsEvent{
  UnblockUserEvent({super.onSuccess, super.onError});
}
// ignore: must_be_immutable
class SendRequestFriendEvent extends UserButtonsEvent{}
// ignore: must_be_immutable
class CancelRequestFriendEvent extends UserButtonsEvent{}
// ignore: must_be_immutable
class CancelFriendEvent extends UserButtonsEvent{}
// ignore: must_be_immutable
class AcceptRequestFriendEvent extends UserButtonsEvent{
  Acceptable code;
  AcceptRequestFriendEvent({required this.code});
}
// ignore: must_be_immutable
class InitButtonsEvent extends UserButtonsEvent{}
// ignore: must_be_immutable
class UpdateButtonsEvent extends UserButtonsEvent{}
