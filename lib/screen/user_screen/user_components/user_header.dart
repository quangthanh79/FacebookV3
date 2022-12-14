
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/user_edit_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserHeader extends StatelessWidget{
  User user;

  UserHeader({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 1.0,
                color: Colors.grey
            )
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 6,
              child: Row(
                children: [
                  GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Icon(Icons.arrow_back),
                    ),
                    // onTap: () => main.back(),
                    onTap: (){},
                  ),
                  Text(user?.username ?? "Người dùng Facebook",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              )
          ),
          Expanded(
              flex: 2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    user!.isMe ? GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0, vertical: 12),
                        child: Icon(
                          Icons.edit,

                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            UserEditScreen.route(this.user)
                        );
                      }
                      // => UserEditScreen.edit(
                      //   context: main.context!,
                      //   main: main
                      // ),
                    ) : Container(),
                    GestureDetector(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12),
                          child: Icon(
                            Icons.search,

                          ),
                        ),
                        onTap: () {}
                    )
                  ]
              ))
        ],
      ),
    );
  }
}