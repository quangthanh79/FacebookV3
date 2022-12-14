

import 'package:equatable/equatable.dart';

abstract class UserFriendEvent extends Equatable{
  const UserFriendEvent();

  @override
  List<Object?> get props => [];
}

class LoadFriendEvent extends UserFriendEvent{
  final String user_id;
  const LoadFriendEvent(this.user_id);
  @override
  List<Object?> get props => [this.user_id];
}


