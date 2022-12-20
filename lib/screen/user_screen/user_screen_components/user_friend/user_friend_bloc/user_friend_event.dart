
part of 'user_friend_bloc.dart';

abstract class UserFriendEvent extends Equatable{
  const UserFriendEvent();

  @override
  List<Object?> get props => [];
}

class LoadFriendEvent extends UserFriendEvent{}
class ReloadFriendEvent extends UserFriendEvent{}


