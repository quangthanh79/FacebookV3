
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_list_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_request_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_suggest_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_header.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_item.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/my_button_style.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class FriendBody extends FriendScreenComponent{
  FriendBody({super.key, required super.main});
  @override
  State<StatefulWidget> createState() => FriendBodyState();
}

class FriendBodyState extends FriendScreenComponentState<FriendBody>{
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late int numFriends;

  @override
  void initState() {
    super.initState();
    numFriends = main.listFriend.length;
    scrollController.addListener(() {
      // print("scroll controller: ");
      // print("offset: ${scrollController.offset}");
      // print("maxExtent: ${scrollController.position.maxScrollExtent}");
      // print("ratio: ${scrollController.offset / scrollController.position.maxScrollExtent}");
      if (scrollController.position.extentAfter < 200){
        // main.loadMore();
        // print("call more............................");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        FriendHeader(main: main,),
        // Container(
        //   padding: const EdgeInsets.all(16),
        //   // decoration: const BoxDecoration(
        //   //   border: Border(bottom: BorderSide(width: 1, color: Colors.black12))
        //   // ),  //
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       getSearchBar(context)
        //     ],
        //   ),
        // ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => Future.delayed(
                        const Duration(seconds: 1),
                        () => main.reloadListFriend(),
                      ),
                      child: ListView(
                          controller: scrollController,
                          addAutomaticKeepAlives: true,
                          padding: const EdgeInsets.all(0),
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: getListWidgetFriends(),
                      ),
                    ),

                )
              ],
            ),
          ),
        )
      ],
    );
  }

  List<Widget> getListWidgetFriends(){
    // print("rebuild all  children");
    print(user);
    List<Widget> list = [
      const SizedBox(height: 8,),
      main is FriendListScreenState && user.isMe ?
        getButtonsBar(context) : Container(),
      const SizedBox(height: 8,),
      Text(
        main is FriendListScreenState ? "$numFriends bạn bè" :
        main is FriendRequestScreenState ?
          "$numFriends lời mời" : "$numFriends gợi ý",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),
      ),
      const SizedBox(height: 8,)
    ];
    for (User friend in main.listFriend) {
      // print("Soos banj la: ${friend.username}");
      list.add(FriendItem(friend: friend,));
    }
    return list;
  }

}


