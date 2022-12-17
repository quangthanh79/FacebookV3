

import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_state.dart';
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
    if (main is FriendListScreenState){
      label = "Không có bạn bè để hiển thị.";
    } else if (main is FriendRequestScreenState ){
      label = "Không có lời mời kết bạn nào.";
    } else if (main is FriendSuggestScreenState ){
      label = "Không có người nào được gợi ý kết bạn.";
    } else {
      label = "Không có gì để hiển thị.";
    }
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
          padding: const EdgeInsets.all(16),
          // decoration: const BoxDecoration(
          //   border: Border(bottom: BorderSide(width: 1, color: Colors.black12))
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getSearchBar(context),
              const SizedBox(height: 8,),
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

  Widget getButtonsBar(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getButton(
            label: "Lời mời",
            callback: (){
              Navigator.push(
                  context,
                  FriendRequestScreen.route(user: user)
              );
            }
        ),
        getButton(
            label: "Gợi ý",
            callback: (){
              Navigator.push(
                  context,
                  FriendSuggestScreen.route(user: user)
              );
            }
        )
      ],
    );
  }

  Widget getButton({
    String label = "Button",
    void Function()? callback
  }){
    return Container(
      margin: const EdgeInsets.only(right: 12, top: 0),
      child: TextButton(
        onPressed: callback ?? (){},
        style: MyButtonStyle(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          borderRadius: BorderRadius.circular(18.0),
          backgroundColor: Colors.black12.withAlpha(25),
        ),
        child: Text(
            label,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16
            )
        ),
      ),
    );
  }

  Widget getSearchBar(BuildContext context){
    return Container(
      constraints: const BoxConstraints(
          maxHeight: 40
      ),
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(48)),
          color: Colors.black12.withAlpha(15)
      ),
      child: TextField(
        controller: textEditingController,
        decoration: const InputDecoration(
            hintText: "Tìm kiếm bạn bè",
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.black45,)
        ),
        cursorColor: Colors.black,
        style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500
        ),
        onSubmitted: (text){
          textEditingController.text = text;
        },
        maxLines: 1,
      ),
    );
  }
}


