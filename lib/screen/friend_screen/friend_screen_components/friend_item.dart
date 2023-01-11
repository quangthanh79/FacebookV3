

import 'package:facebook_auth/blocs/block/BlockApiProvider.dart';
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_item_bloc/friend_item_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/cancel_friend_menu_bottom.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/my_button_style.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:shimmer/shimmer.dart';


// ignore: must_be_immutable
class FriendItem extends StatefulWidget{
  Friend friend;
  FriendItem({super.key, required this.friend});
  // ignore: no_logic_in_create_state
  @override FriendItemState_ createState() => FriendItemState_();
}

// ignore: must_be_immutable, camel_case_types
class FriendItemState_ extends State<FriendItem> with AutomaticKeepAliveClientMixin{
  late Friend friend;
  late FriendItemBloc friendItemBloc;

  @override void initState(){
    super.initState();
    friend = widget.friend;
    friendItemBloc = FriendItemBloc(
        friend: friend,
        friendRepository: getIt<FriendRepository>()
    );
    print("init friend ${friend.username}");
  }

  @override void didUpdateWidget(FriendItem oldWidget){
    super.didUpdateWidget(oldWidget);
    friend.copyFrom(widget.friend);
    print("update friend ${friend.username}");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    friendItemBloc.add(InitButtonsEvent());
    print("rebuild friend ${friend.username}");
    return BlocProvider<FriendItemBloc>(
      create: (ctx) => friendItemBloc,
      child: BlocBuilder<FriendItemBloc, FriendItemState>(
        bloc: friendItemBloc,
        builder: (context, state){
          if (state.status == FriendItemStatus.BLOCK){
            return Container(
              height: 60,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  // border: Border.all(color: Colors.black, width: 1)
                  color: Colors.black12.withAlpha(15)
              ),
              alignment: Alignment.center,
              child: const Text("This user blocked you or you blocked this user",
                style: TextStyle(
                  fontWeight: FontWeight.w600
                ),
              ),
            );
          }
          if (state.status == FriendItemStatus.LOADING){
            return getShimmer();
          }
          return TextButton(
            onPressed: (){},
            style: MyButtonStyle(
              padding: const EdgeInsets.symmetric(vertical: 0),
              backgroundColor: Colors.white.withAlpha(0)
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: viewUser,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: getImage(
                          uri: friend.avatar ?? 'assets/images/default_avatar_image.jpg',
                          defaultUri: 'assets/images/default_avatar_image.jpg',
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: viewUser,
                            child: Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(friend.username ?? "Người dùng Facebook",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          state.status != FriendItemStatus.ME ?
                          Text(
                            "${friend.same_friends} bạn chung",
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 13
                            ),
                          ) : Container()
                        ],
                      )
                  ),
                  getButtons(context, state.status)
                ]
            )
          );
        },
      )
    );
  }

  Widget getShimmer(){
    return Shimmer.fromColors(
        baseColor: Colors.black12.withAlpha(15),
        highlightColor: Colors.transparent,
        child: Row(
          children: [
            Expanded(child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.black
              ),
            ))
          ],
        )
    );

  }

  void viewUser(){
    Navigator.push(
      context,
      UserScreen.route(
          user: User(
            id: friend.user_id,
            avatar: friend.avatar
          ),
          onBack: (){
            friendItemBloc.add(UpdateButtonsEvent());
          }
      )
    );
  }

  Widget getButtons(BuildContext context, FriendItemStatus status){
    switch (status){
      case FriendItemStatus.NOT_FRIEND:
        return getButton(
          theme: Theme.BLUE,
          label: "Thêm bạn bè",
          function: () => friendItemBloc.add(SendRequestEvent())
        );
      case FriendItemStatus.IS_FRIEND:
        return getButton(
          theme: Theme.DARK,
          label: "Hủy kết bạn",
          function: (){
            CancelFriendMenuBottom.showBottomMenu(
              context: context,
              onSuccess: (){
                friendItemBloc.add(CancelFriendEvent());
              }
            );
          }
          // function: () => friendItemBloc.add(CancelFriendEvent())
        );
      case FriendItemStatus.REQUESTED:
        return Row(
          children: [
            getButton(
                theme: Theme.BLUE,
                label: "Chấp nhận",
                function: () => friendItemBloc.add(AcceptRequestEvent(code: Acceptable.ACCEPT))
            ),
            const SizedBox(width: 3,),
            getButton(
                theme: Theme.DARK,
                label: "Từ chối",
                function: () => friendItemBloc.add(AcceptRequestEvent(code: Acceptable.DECLINE))
            ),
          ],
        );
      case FriendItemStatus.REQUESTING:
        return getButton(
          theme: Theme.DARK,
          label: "Hủy lời mời",
            function: () => friendItemBloc.add(CancelRequestEvent())
        );
      case FriendItemStatus.LOADING:
      case FriendItemStatus.ME:
      default:
        return Container();
    }
  }

  TextButton getButton({
    Theme theme = Theme.BLUE,
    String label = "Kết bạn",
    void Function()? function,
  }){
    return TextButton(
        onPressed: function?? (){},
        style: MyButtonStyle(
          backgroundColor: theme == Theme.DARK ? Colors.black12 : Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme == Theme.DARK ? Colors.black : Colors.white
          ),
        )
    );
  }

  @override
  bool get wantKeepAlive => true;
}

enum Theme { DARK, BLUE }