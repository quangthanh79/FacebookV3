


import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FriendItem extends StatelessWidget{
  Friend friend;
  late User user;

  FriendItem({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Text(friend.username!);
  }

}