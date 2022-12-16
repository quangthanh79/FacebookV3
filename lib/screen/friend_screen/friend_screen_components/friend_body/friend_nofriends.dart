

import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_state.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_list_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_header.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class FriendNoFriends extends FriendScreenComponent{
  FriendNoFriends({super.key, required super.main});
  @override
  State<StatefulWidget> createState() => FriendNoFriendsState();
}

class FriendNoFriendsState extends FriendScreenComponentState<FriendNoFriends>{
  late String label;
  @override
  void initState() {
    super.initState();
    if (main is FriendListScreenState){
      label = "Không có bạn bè để hiển thị.";
    } else {
      label = "Không có gì để hiển thị.";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        FriendHeader(main: main,),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                      addAutomaticKeepAlives: true,
                      padding: const EdgeInsets.all(0),
                      children: [
                        Container(
                            height: 1000,
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            decoration: const BoxDecoration(
                                color: Colors.black26
                            ),
                            alignment: Alignment.topCenter,
                            child: Text(
                              label,
                              style: const TextStyle(
                                fontSize: 16
                              ),
                            )
                        ),
                      ]
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}


