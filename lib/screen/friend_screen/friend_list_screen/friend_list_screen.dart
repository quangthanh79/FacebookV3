

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_state.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_body.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_loading.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_nofriends.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'OpenSans', platform: TargetPlatform.iOS, backgroundColor: Colors.black12),
        home: Scaffold(
            resizeToAvoidBottomInset: true,
            body: BlocProvider<FriendListBloc>(
                create: (context) => friendListBloc,
                child: BlocBuilder<FriendListBloc, FriendListState>(
                    bloc: friendListBloc,
                    builder: (context, state){
                      Widget content;
                      switch(state.status){
                        case FriendListStatus.LOADING:
                          content = FriendLoading(main: this);
                          break;
                        case FriendListStatus.LOADED:
                          content = FriendBody(main: this);
                          print("tiếp đây");
                          break;
                        case FriendListStatus.NO_FRIENDS:
                          content = FriendNoFriends(main: this);
                          break;
                        default:
                          content = FriendLoading(main: this);
                          break;
                      }
                      return content;
                    }
                )
            )
        )
    );
  }
}


