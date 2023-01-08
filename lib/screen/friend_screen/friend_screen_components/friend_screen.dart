

// ignore: must_be_immutable
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_request_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_suggest_screen.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_body.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_loading.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_nofriends.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/my_button_style.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
abstract class FriendScreen extends StatefulWidget{
  User user;
  void Function()? onBack;
  FriendScreen({super.key, required this.user, this.onBack});
}

abstract class FriendScreenState<T extends FriendScreen> extends State<T> with AutomaticKeepAliveClientMixin{
  late User user;
  // late ListFriend listFriend;
  List<User> listFriend = [];
  late FriendListBloc friendListBloc;
  late String label, responseForNoFriends;

  @override void initState(){
    super.initState();
    user = widget.user;
    // listFriend = ListFriend(list: [], total: 0);
    friendListBloc = FriendListBloc(
        user: user,
        listFriend: listFriend,
        friendRepository: getIt<FriendRepository>()
    );
  }

  @override Widget build(BuildContext context){
    super.build(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocProvider<FriendListBloc>(
            create: (context) => friendListBloc,
            child: BlocBuilder<FriendListBloc, FriendListState>(
                bloc: friendListBloc,
                builder: (context, state){
                  Widget content;
                  switch(state.status){
                    case FriendListStatus.LOADING:
                      content = FriendLoading(main: this);
                      break;
                    case FriendListStatus.LOADED:
                      content = FriendBody(main: this);
                      break;
                    case FriendListStatus.NO_FRIENDS:
                      content = FriendNoFriends(main: this);
                      break;
                    default:
                      content = FriendLoading(main: this);
                      break;
                  }
                  return content;
                }
            )
        )
    );
  }

  void back(){
    Navigator.pop(context);
  }
  @override get wantKeepAlive => true;
  void reloadListFriend();
  void loadMore();
}

// ignore: must_be_immutable
abstract class FriendScreenComponent extends StatefulWidget{
  late FriendScreenState main;
  FriendScreenComponent({super.key, required this.main});
}

abstract class FriendScreenComponentState<T extends FriendScreenComponent> extends State<T> with AutomaticKeepAliveClientMixin{
  late FriendScreenState main;
  late User user;
  @override void initState(){
    super.initState();
    main = widget.main;
    user = main.user;
  }
  void back(){
    main.back();
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
                  FriendRequestScreen.route(user: user, onBack: (){})
              );
            }
        ),
        getButton(
            label: "Gợi ý",
            callback: (){
              Navigator.push(
                  context,
                  FriendSuggestScreen.route(user: user, onBack: (){})
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

  Widget getSearchBar(BuildContext context, TextEditingController textEditingController){
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

  @override get wantKeepAlive => true;
}

