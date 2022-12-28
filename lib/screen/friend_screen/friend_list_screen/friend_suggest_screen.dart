


import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class FriendSuggestScreen extends FriendScreen{
  FriendSuggestScreen({super.key, required super.user});
  @override
  State<StatefulWidget> createState() => FriendSuggestScreenState();

  static Route<void> route({
    required User user,
  }) {
    return MaterialPageRoute(
        builder: (context) => FriendSuggestScreen(
            user: user
        )
    );
  }
}

class FriendSuggestScreenState extends FriendScreenState<FriendSuggestScreen>{

  @override void initState(){
    super.initState();
    friendListBloc.add(LoadListSuggestEvent());
    label = "Những người bạn có thể biết";
    responseForNoFriends = "Không có ai được gợi ý kết bạn với bạn.";
  }

  @override
  void reloadListFriend() {
    friendListBloc.add(BackgroundLoadListSuggestEvent());
  }

  @override
  void loadMore() {
    friendListBloc.add(LoadMoreListSuggestEvent());
  }
}


