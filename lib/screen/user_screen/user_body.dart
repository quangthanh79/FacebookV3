
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/user_screen/user_friend/user_friend.dart';
import 'package:facebook_auth/screen/user_screen/user_infor/user_infor.dart';
import 'package:facebook_auth/screen/user_screen/user_avatar/user_avatar.dart';
import 'package:flutter/material.dart';

import 'user_components/user_header.dart';


class UserBody extends StatefulWidget{
  User user;
  ListFriend listFriend;
  UserBody({super.key,required this.user,required this.listFriend});

  @override
  UserBodyState createState() => UserBodyState();

}

class UserBodyState extends State<UserBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          UserHeader(user: widget.user),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                        padding: const EdgeInsets.all(0),
                        children: [
                          UserAvatar(user: widget.user),
                          SizedBox(
                            height: 16,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black26
                              ),
                            ),
                          ),
                          UserInfor(user: widget.user,),
                          SizedBox(height: 16,
                            child: Container(decoration: const BoxDecoration(
                                color: Colors.black26),),),
                          UserFriend(user: widget.user,listFriend: widget.listFriend),
                          SizedBox(
                            height: 16,
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.black26
                                )
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blue,
                                    width: 1
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(8))
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Nhập",
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              maxLength: 120,
                              onTap: (){
                                print("Tab textfield");
                              },
                            ),
                          ),
                        ]
                    )
                )
              ],
            ),
          )
        ],
      )
    );
  }
}