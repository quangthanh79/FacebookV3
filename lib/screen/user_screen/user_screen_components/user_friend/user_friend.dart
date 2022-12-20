

import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_list_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_friend/user_friend_bloc/user_friend_bloc.dart';
import 'package:flutter/material.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// ignore: must_be_immutable
class UserFriend extends UserScreenComponent {
  UserFriend({super.key, required super.main});

  @override
  State<StatefulWidget> createState() => UserFriendState_();
}

// ignore: camel_case_types
class UserFriendState_ extends UserScreenComponentState<UserFriend>{
  late ListFriend listFriend;
  late UserFriendBloc userFriendBloc;

  @override void initState(){
    super.initState();
    userFriendBloc = main.userFriendBloc;
    // userFriendBloc.add(ReloadFriendEvent());
    listFriend = userFriendBloc.listFriend;
  }

  @override
  Widget build(BuildContext context){
    return BlocProvider<UserFriendBloc>(
      create: (context) => userFriendBloc,
      child: BlocBuilder<UserFriendBloc, UserFriendState>(
        bloc: userFriendBloc,
        builder: (context, state){
          return getBody(context);
        }
      )
    );
  }

  Widget getBody(context){
    int numfriends = listFriend.total ?? 0;
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: const Text("Bạn bè",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19
                        ),
                      ),
                      onTap: (){
                        main.userFriendBloc.add(ReloadFriendEvent());
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${listFriend.total ?? 0} người bạn",
                      style: TextStyle(
                          color: Colors.grey.shade500
                      ),
                    ),
                  ],
                ),
                user.isMe ? GestureDetector(
                    child: Text(
                        "Tìm bạn bè",
                        style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 15
                        )
                    ),
                    onTap: (){}
                ) : Container()
              ],
            )
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Row(
            children: [
              getFriendItem(numfriends > 0 ? listFriend.list![0] : null),
              const SizedBox(width: 8,),
              getFriendItem(numfriends > 1 ? listFriend.list![1] : null),
              const SizedBox(width: 8,),
              getFriendItem(numfriends > 2 ? listFriend.list![2] : null)
            ],
          ),
        ),
        numfriends > 3 ?
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Row(
            children: [
              getFriendItem(numfriends > 3 ? listFriend.list![3] : null),
              const SizedBox(width: 8,),
              getFriendItem(numfriends > 4 ? listFriend.list![4] : null),
              const SizedBox(width: 8,),
              getFriendItem(numfriends > 5 ? listFriend.list![5] : null)
            ],
          ),
        ) : Container(),
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              FriendListScreen.route(user: user)
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black12,
            ),
            alignment: Alignment.center,
            child: const Text(
              "Xem tất cả bạn bè",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,)
      ],
    );
  }

  Widget getFriendItem(Friend? friend){
    if(friend == null){
      return Expanded(
          flex: 1,
          child: Container()
      );
    }
    return Expanded(
      flex: 1,
      child: GestureDetector(
        child: SizedBox(
          height: !user.isMe ? 175 : 155,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: getImage(
                  uri: friend.avatar,
                  defaultUri: 'assets/images/default_avatar_image.jpg',
                  height: 120,
                  width: 120
                ),
              ),
              const SizedBox(height: 5,),
              SizedBox(
                height: !user.isMe ? 50 : 30,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          maxHeight: 30
                        ),
                        child: Text(
                          friend.username ?? "Người dùng Facebook",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      const SizedBox(height: 3,),
                      !user.isMe ? SizedBox(
                        height: 17,
                        child: Text(
                          "${friend.same_friends ?? 0} bạn chung",
                          style: const TextStyle(
                              fontSize: 12
                          ),
                        ),
                      ) : Container()
                    ],
                  )
                )
              )
            ],
          ),
        ),
        onTap: (){
          // print(friend);
          if (friend.user_id == null) return;
          User user = User(
            id: friend.user_id,
            username: friend.username,
            avatar: friend.avatar,
          );
          Navigator.push(
              main.context,
              MaterialPageRoute(
                  builder: (context) => UserScreen(
                    user: user
                  )
              )
          );
        },
      )
    );
  }
}
