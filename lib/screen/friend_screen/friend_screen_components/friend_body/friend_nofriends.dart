

import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_list_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_request_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_suggest_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_header.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/my_button_style.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class FriendNoFriends extends FriendScreenComponent{
  FriendNoFriends({super.key, required super.main});
  @override
  State<StatefulWidget> createState() => FriendNoFriendsState();
}

class FriendNoFriendsState extends FriendScreenComponentState<FriendNoFriends>{
  TextEditingController textEditingController = TextEditingController();

  late String label;
  @override
  void initState() {
    super.initState();
    label = main.responseForNoFriends;
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        FriendHeader(main: main,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // decoration: const BoxDecoration(
          //   border: Border(bottom: BorderSide(width: 1, color: Colors.black12))
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // getSearchBar(context),
              // const SizedBox(height: 8,),
              main is FriendListScreenState && user.isMe ?
              getButtonsBar(context) : Container()
            ],
          ),
        ),
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


