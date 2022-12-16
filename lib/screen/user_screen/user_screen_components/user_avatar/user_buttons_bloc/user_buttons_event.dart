

import 'package:equatable/equatable.dart';

enum Acceptable{
  ACCEPT, DECLINE
}

class UserButtonsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

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

