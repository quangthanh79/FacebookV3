

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FriendListScreen extends FriendScreen{
  FriendListScreen({super.key, required super.user});
  @override
  State<StatefulWidget> createState() => FriendListScreenState();

  static Route<void> route({
    required User user,
  }) {
    return MaterialPageRoute(
        builder: (context) => FriendListScreen(
            user: user
        )
    );
  }
}

class FriendListScreenState extends FriendScreenState<FriendListScreen>{

  @override void initState(){
    super.initState();
    friendListBloc.add(LoadListFriendEvent());
    label = "Bạn bè";
    responseForNoFriends = "Bạn hiện không có bạn bè nào để hiển thị.";
    if (user.id != SessionUser.idUser){
      label = user.username ?? "Người dùng facebook";
      responseForNoFriends = "${user.username?? ""} không có bạn bè nào để hiển thị.";
    }
  }

  @override
  void reloadListFriend() {
    friendListBloc.add(BackgroundLoadListFriendEvent());
  }

  @override
  void loadMore() {
    friendListBloc.add(LoadMoreListFriendEvent());
  }

}


