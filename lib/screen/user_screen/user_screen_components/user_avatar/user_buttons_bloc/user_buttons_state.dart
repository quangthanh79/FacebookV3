

part of 'user_buttons_bloc.dart';

enum UserButtonStatus{
  NOT_FRIEND, IS_FRIEND, REQUESTING, REQUESTED, ME, INITIAL, BLOCKING, BLOCKED
}

// ignore: must_be_immutable
class UserButtonsState extends Equatable{
  UserButtonStatus userButtonStatus;

  @override
  List<Object?> get props => [userButtonStatus];

  UserButtonsState({required this.userButtonStatus});

}

