
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/search_screen/search_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/user_edit_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserHeader extends UserScreenComponent {
  UserHeader({super.key, required super.main});

  @override
  State<StatefulWidget> createState() => UserHeaderState();
}

class UserHeaderState extends UserScreenComponentState<UserHeader>{
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    onTap: back,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(user.username ?? "Người dùng Facebook",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
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
                    user.isMe ? GestureDetector(
                      onTap: main.routeEditScreen,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0, vertical: 12),
                        child: Icon(
                          Icons.edit,

                        ),
                      )
                    ) : Container(),
                    GestureDetector(
                        onTap: (){
                          showSearch(
                              context: context,
                              delegate: MyCustomDelegate()
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12),
                          child: Icon(
                            Icons.search,
                          ),
                        )
                    )
                  ]
              ))
        ],
      ),
    );
  }
}