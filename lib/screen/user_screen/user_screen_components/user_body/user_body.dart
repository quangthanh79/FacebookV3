
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_event.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_avatar/user_avatar.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_friend/user_friend.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_friend/user_friend_bloc/user_friend_event.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_header.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_infor/user_infor.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class UserBody extends UserScreenComponent {
  UserBody({super.key,required super.main});

  @override
  State<StatefulWidget> createState() => UserBodyState();
}

class UserBodyState extends UserScreenComponentState<UserBody>{
  late ScrollController scrollController;
  late double scrollPosition;

  @override void initState(){
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      scrollPosition = scrollController.position.pixels;
      // print("scroll height extent: ${scrollController.position.maxScrollExtent}");
      // print("scroll offset: ${scrollController.offset}");
      print("scroll position: ${scrollController.position.pixels}");
      // if (scrollPosition <= -200){
      //   main.userInforBloc.add(LoadUserEvent());
      // }
    });
  }
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          UserHeader( main: main ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                    child: RefreshIndicator(
                      child: ListView(
                          addAutomaticKeepAlives: true,
                          // controller: scrollController,
                          padding: const EdgeInsets.all(0),
                          children: [
                            UserAvatar(main: main),
                            SizedBox(
                              height: 16,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.black26
                                ),
                              ),
                            ),
                            UserInfor(main: main,),
                            SizedBox(height: 16,
                              child: Container(decoration: const BoxDecoration(
                                  color: Colors.black26),),),
                            UserFriend(main: main),
                            SizedBox(
                              height: 16,
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black26
                                  )
                              ),
                            ),
                          ]
                      ),
                      onRefresh: (){
                        return Future.delayed(
                            const Duration(seconds: 1),
                            main.refresh
                        );
                      },
                    )
                )
              ],
            ),
          )
        ],
      )
    );
  }
}