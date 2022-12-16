

import 'package:equatable/equatable.dart';

abstract class UserFriendEvent extends Equatable{
  const UserFriendEvent();

  @override
  List<Object?> get props => [];
}

class LoadFriendEvent extends UserFriendEvent{}
class ReloadFriendEvent extends UserFriendEvent{}


