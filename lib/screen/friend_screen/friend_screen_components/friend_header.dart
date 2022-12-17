
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_list_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_request_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_suggest_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FriendHeader extends FriendScreenComponent {
  FriendHeader({super.key, required super.main});
  @override
  State<StatefulWidget> createState() => FriendHeaderState();
}

class FriendHeaderState extends FriendScreenComponentState<FriendHeader>{
  late String label;
  @override void initState(){
    super.initState();
    if (user.id! != SessionUser.idUser){
      label = user.username!;
    } else {
      if (main is FriendListScreenState){
        label = "Bạn bè";
      } else if (main is FriendRequestScreenState){
        label = "Lời mời kết bạn";
      } else if (main is FriendSuggestScreenState){
        label = "Gợi ý";
      } else {
        label = user.username!;
      }
    }
  }
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
                    child: Text(
                      label,
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
                    GestureDetector(
                        onTap: (){},
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
