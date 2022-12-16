

// ignore: must_be_immutable
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_event.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
abstract class FriendScreen extends StatefulWidget{
  User user;
  FriendScreen({super.key, required this.user});
}

abstract class FriendScreenState<T extends FriendScreen> extends State<T>{
  late User user;
  late ListFriend listFriend;
  late FriendListBloc friendListBloc;
  @override void initState(){
    super.initState();
    user = widget.user;
    listFriend = ListFriend(list: [], total: 0);
    friendListBloc = FriendListBloc(
        user: user,
        listFriend: listFriend,
        friendRepository: getIt<FriendRepository>()
    )..add(LoadListFriendEvent());
  }
  void back(){
    Navigator.pop(context);
  }
}

// ignore: must_be_immutable
abstract class FriendScreenComponent extends StatefulWidget{
  late FriendScreenState main;
  late User user;
  FriendScreenComponent({super.key, required this.main}){
    user = main.user;
  }
}

abstract class FriendScreenComponentState<T extends FriendScreenComponent> extends State<T>{
  late FriendScreenState main;
  late User user;
  @override void initState(){
    super.initState();
    user = widget.user;
    main = widget.main;
  }
  void back(){
    main.back();
  }
}

