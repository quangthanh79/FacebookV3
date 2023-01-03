
import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/icon/person_icons.dart';
import 'package:facebook_auth/screen/chat_screen/chat_detail_screen.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/friend_chat.dart';




class FriendItem extends StatelessWidget{
  final Friends friend;
  const FriendItem({
    Key? key,
    required this.friend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("URL________"+(friend.avatar ?? "NULL"));
    return Container(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
        width: 70,
        color: Colors.white,
        child: CupertinoButton(
            onPressed: (){

              Navigator.push(
                  context,
                  ChatDetailScreen.route(
                      Partner(
                        id: this.friend.user_id,
                        username: this.friend.username,
                        avatar: this.friend.avatar
                      )
                  )
              );
            },
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(

              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: getImage(
                    uri: friend.avatar ?? 'assets/images/default_avatar_image.jpg',
                    defaultUri: 'assets/images/default_avatar_image.jpg',
                    width: 60,
                    height: 60,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(child: Container(
                        color: Colors.white,
                        child: Text(
                          friend.username ?? "Người dùng facebook",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w400
                          ),
                          textAlign: TextAlign.center,
                        )
                    ))
                  ],
                )


              ],
            )
        )

    );

  }

}