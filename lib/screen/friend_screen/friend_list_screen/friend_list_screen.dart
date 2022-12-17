

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_event.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_state.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_body.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_loading.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_nofriends.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (user.id != SessionUser.idUser){
      label = user.username ?? "Người dùng facebook";
    }
    responseForNoFriends = "Bạn hiện không có bạn bè nào để hiển thị.";
  }

}


