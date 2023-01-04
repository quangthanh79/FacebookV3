


import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class FriendRequestScreen extends FriendScreen{
  FriendRequestScreen({super.key, required super.user, super.onBack});
  @override
  State<StatefulWidget> createState() => FriendRequestScreenState();

  static Route<void> route({
    required User user,
    void Function()? onBack
  }) {
    return MaterialPageRoute(
        builder: (context) => FriendRequestScreen(
            user: user, onBack: onBack,
        )
    );
  }
}

class FriendRequestScreenState extends FriendScreenState<FriendRequestScreen>{

  @override void initState(){
    super.initState();
    friendListBloc.add(LoadListRequestEvent());
    label = "Lời mời kết bạn";
    responseForNoFriends = "Không có lời mời kết bạn nào.";
  }

  @override
  void reloadListFriend() {
    friendListBloc.add(BackgroundLoadListRequestEvent());
  }

  @override
  void loadMore() {
    friendListBloc.add(LoadMoreListRequestEvent());
  }
}


