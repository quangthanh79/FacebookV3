

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/screen/user_screen/user_friend/user_friend_bloc/user_friend_bloc.dart';
import 'package:facebook_auth/screen/user_screen/user_friend/user_friend_bloc/user_friend_event.dart';
import 'package:facebook_auth/screen/user_screen/user_friend/user_friend_bloc/user_friend_state.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/friend.dart';


// ignore: must_be_immutable
class UserFriend extends StatelessWidget{
  // UserScreen main;
  User user;
  BuildContext? context;
  ListFriend listFriend;

  UserFriend({super.key, required this.user, required this.listFriend});
  @override
  Widget build(BuildContext context){
    this.context = context;

    return BlocProvider<UserFriendBloc>(
      create: (context) => UserFriendBloc(friendRepository: getIt.get<FriendRepository>()),
      child: BlocBuilder<UserFriendBloc, UserFriendState>(
        builder: (context, state){
          return getBody(context);
        }
      )
    );
  }

  Widget getBody(context){
    int numfriends = listFriend?.total ?? 0;
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
                    const Text("Bạn bè",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${listFriend?.total ?? 0} người bạn",
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
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              getFriendItem(numfriends > 0 ? listFriend!.list![0] : null),
              const SizedBox(width: 8,),
              getFriendItem(numfriends > 1 ? listFriend!.list![1] : null),
              const SizedBox(width: 8,),
              getFriendItem(numfriends > 2 ? listFriend!.list![2] : null)
            ],
          ),
        ),
        numfriends > 3 ?
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              getFriendItem(numfriends > 3 ? listFriend!.list![3] : null),
              const SizedBox(width: 8,),
              getFriendItem(numfriends > 4 ? listFriend!.list![4] : null),
              const SizedBox(width: 8,),
              getFriendItem(numfriends > 5 ? listFriend!.list![5] : null)
            ],
          ),
        ) : Container(),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          height: 175,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: friend.avatar != null ? Image.network(
                    friend.avatar!,
                    fit: BoxFit.fill,
                    height: 120,
                ) : Image.asset(
                  'assets/images/default_avatar_image.jpg',
                  fit: BoxFit.fill,
                  height: 120,
                ),
              ),
              const SizedBox(height: 5,),
              SizedBox(
                height: 50,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Text(
                          friend.username ?? "Người dùng Facebook",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Text(
                          "${friend.same_friends ?? 0} bạn chung",
                          style: const TextStyle(
                              fontSize: 12
                          ),
                        ),
                      )
                    ],
                  )
                )
              )
            ],
          ),
        ),
        onTap: (){
          print(friend);
          if (friend.user_id == null) return;
          User user = User(
            id: friend.user_id,
            username: friend.username,
            avatar: friend.avatar,
          );
          Navigator.push(
              context!,
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
