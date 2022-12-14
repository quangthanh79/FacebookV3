

import 'package:equatable/equatable.dart';

enum UserButtonStatus{
  NOT_FRIEND, IS_FRIEND, REQUESTING, REQUESTED, ME, INITIAL
}

class UserButtonsState extends Equatable{
  UserButtonStatus userButtonStatus;

  @override
  List<Object?> get props => [userButtonStatus];

  UserButtonsState({required this.userButtonStatus});

}

