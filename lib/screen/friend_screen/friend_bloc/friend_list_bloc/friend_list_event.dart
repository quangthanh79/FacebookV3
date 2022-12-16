


import 'package:equatable/equatable.dart';

class FriendListEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

// Friend:
class LoadListFriendEvent extends FriendListEvent{}
// ignore: must_be_immutable
class LoadListFriendInNumberEvent extends FriendListEvent{
  int number;
  LoadListFriendInNumberEvent({required this.number});
}
class BackgroundLoadListFriendEvent extends FriendListEvent{}
class ReloadListFriendEvent extends FriendListEvent{}


// Request
class LoadListRequestEvent extends FriendListEvent{}
// ignore: must_be_immutable
class LoadListRequestInNumberEvent extends FriendListEvent{
  int number;
  LoadListRequestInNumberEvent({required this.number});
}
class BackgroundLoadListRequestEvent extends FriendListEvent{}
class ReloadListRequestEvent extends FriendListEvent{}

// Suggest
class LoadListSuggestEvent extends FriendListEvent{}
// ignore: must_be_immutable
class LoadListSuggestInNumberEvent extends FriendListEvent{
  int number;
  LoadListSuggestInNumberEvent({required this.number});
}
class BackgroundLoadListSuggestEvent extends FriendListEvent{}
class ReloadListSuggestEvent extends FriendListEvent{}

