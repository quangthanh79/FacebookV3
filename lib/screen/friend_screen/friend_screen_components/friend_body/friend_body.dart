
import 'package:facebook_auth/data/models/friend.dart';
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
    numFriends = main.listFriend.total!;
    scrollController.addListener(() {
      // print("scroll controller: ");
      // print("offset: ${scrollController.offset}");
      // print("maxExtent: ${scrollController.position.maxScrollExtent}");
      if (numFriends + 2 < main.user.listing!){
        if (scrollController.offset / scrollController.position.maxScrollExtent > 0.75){
          main.loadListFriendInNumber((numFriends * 1.25).ceil());
        }
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
        Container(
          padding: const EdgeInsets.all(16),
          // decoration: const BoxDecoration(
          //   border: Border(bottom: BorderSide(width: 1, color: Colors.black12))
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getSearchBar(context)
            ],
          ),
        ),
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
    print("rebuild all  children");
    List<Widget> list = [
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
    ];
    for (Friend friend in main.listFriend.list!) {
      print("Soos banj la: ${friend.username}");
      list.add(FriendItem(friend: friend,));
    }
    return list;
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


