


import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_event.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_state.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_body.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_loading.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_nofriends.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class FriendRequestScreen extends FriendScreen{
  FriendRequestScreen({super.key, required super.user});
  @override
  State<StatefulWidget> createState() => FriendRequestScreenState();

  static Route<void> route({
    required User user,
  }) {
    return MaterialPageRoute(
        builder: (context) => FriendRequestScreen(
            user: user
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

}


