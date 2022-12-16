
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_avatar/user_avatar.dart';
import 'package:flutter/material.dart';
import '../user_header.dart';

// ignore: must_be_immutable
class UserLoading extends UserScreenComponent {
  UserLoading({super.key, required super.main});

  @override
  State<StatefulWidget> createState() => UserLoadingState();
}

class UserLoadingState extends UserScreenComponentState<UserLoading>{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        UserHeader(main: main),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                      addAutomaticKeepAlives: true,
                      padding: const EdgeInsets.all(0),
                      children: [
                        UserAvatar(main: main),
                        Container(
                            height: 1000,
                            decoration: const BoxDecoration(
                                color: Colors.black26
                            ),
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(height: 30,),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
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
}

