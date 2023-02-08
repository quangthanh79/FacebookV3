
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_list_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_request_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_header.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_item.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
    numFriends = main.listFriend.total;
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 200){
        main.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<FriendListBloc, FriendListState>(
        bloc: main.friendListBloc,
        builder: (context, state){
          numFriends = main.listFriend.total;
          print("debug: $numFriends"); //
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
    );
  }

  List<Widget> getListWidgetFriends(){
    print("rebuild all  children");
    // print(user);
    List<Widget> list = [
      const SizedBox(height: 8,),
      main is FriendListScreenState && user.isMe ?
        getButtonsBar(context) : Container(),
      const SizedBox(height: 8,),
      Text(
        main is FriendListScreenState ? "$numFriends bạn bè" :
        main is FriendRequestScreenState ? "$numFriends lời mời" : "$numFriends gợi ý",
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
        ),
      ),
      const SizedBox(height: 8,)
    ];
    for (Friend friend in main.listFriend.list) {
      // print("Soos banj la: ${friend.username}");
      list.add(Container(
        child: FriendItem(friend: friend,),
      ));
    }
    return list;
  }

}


