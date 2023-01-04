
part of 'friend_list_bloc.dart';

class FriendListEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

// Friend:
class LoadListFriendEvent extends FriendListEvent{}
// ignore: must_be_immutable
class LoadMoreListFriendEvent extends FriendListEvent{}
class BackgroundLoadListFriendEvent extends FriendListEvent{}
class ReloadListFriendEvent extends FriendListEvent{}


// Request
class LoadListRequestEvent extends FriendListEvent{}
// ignore: must_be_immutable
class LoadMoreListRequestEvent extends FriendListEvent{}
class BackgroundLoadListRequestEvent extends FriendListEvent{}
class ReloadListRequestEvent extends FriendListEvent{}

// Suggest
class LoadListSuggestEvent extends FriendListEvent{}
// ignore: must_be_immutable
class LoadMoreListSuggestEvent extends FriendListEvent{}
class BackgroundLoadListSuggestEvent extends FriendListEvent{}
class ReloadListSuggestEvent extends FriendListEvent{}

