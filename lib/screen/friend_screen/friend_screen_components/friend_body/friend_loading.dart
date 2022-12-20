

import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_header.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class FriendLoading extends FriendScreenComponent{
  FriendLoading({super.key, required super.main});
  @override
  State<StatefulWidget> createState() => FriendLoadingState();
}

class FriendLoadingState extends FriendScreenComponentState<FriendLoading>{
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
                            decoration: const BoxDecoration(
                                color: Colors.black26
                            ),
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(height: 30,),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
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


