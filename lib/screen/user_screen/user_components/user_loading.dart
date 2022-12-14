
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/user_screen/user_avatar/user_avatar.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'user_header.dart';

// ignore: must_be_immutable
class UserLoading extends StatelessWidget{
  User user;
  UserLoading({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        UserHeader(user: user),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        UserAvatar(user: this.user),
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

