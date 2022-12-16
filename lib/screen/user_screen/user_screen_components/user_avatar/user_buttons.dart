

import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/screen/chat_screen/chat_detail_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/user_edit_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_event.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/menu_bottom.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_avatar/user_buttons_bloc/user_buttons_bloc.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_avatar/user_buttons_bloc/user_buttons_event.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_avatar/user_buttons_bloc/user_buttons_state.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum Theme {blue, dark}

// ignore: must_be_immutable
class UserButtons extends UserScreenComponent {
  UserButtons({super.key, required super.main});
  @override
  State<StatefulWidget> createState() => UserButtonsState_();
}

// ignore: camel_case_types
class UserButtonsState_ extends UserScreenComponentState<UserButtons>{
  late UserButtonsBloc userButtonsBloc;
  @override void initState(){
    super.initState();
    userButtonsBloc = UserButtonsBloc(
      user: user,
      friendRepository: getIt.get<FriendRepository>(),
    )..add(InitButtonsEvent());
  }

  @override
  Widget build(BuildContext context){
    return BlocProvider<UserButtonsBloc>(
      create: (context) => userButtonsBloc,
      child: BlocBuilder<UserButtonsBloc, UserButtonsState>(
        bloc: userButtonsBloc,
        builder: (context, state){
          // ignore: unnecessary_type_check
          if (state is UserButtonsState){
            switch (state.userButtonStatus){
              case UserButtonStatus.ME:
                return getMeButtons(context);
              case UserButtonStatus.IS_FRIEND:
                return getFriendButtons(context);
              case UserButtonStatus.REQUESTING:
                return getSendButtons(context);
              case UserButtonStatus.REQUESTED:
                return getReceiveButtons(context);
              case UserButtonStatus.NOT_FRIEND:
                return getNotRelativeButtons(context);
              case UserButtonStatus.INITIAL:
                return Container();
            }
            // return getNotRelativeButtons(context);
          }
          return Container();
        },
      )
    );
  }

  Widget getMeButtons(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){},
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8)
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white
                      ),
                      child: const Icon(Icons.add, color: Colors.blue, size: 20,),
                    ),
                    const Text("Thêm vào tin",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    )
                  ],
                )
            ),
          ),
          Row(
            children: [
              getButton(
                  theme: Theme.dark,
                  label: "Chỉnh sửa trang cá nhân",
                  flex: 7,
                  icon: Icons.edit,
                  function: (){
                    Navigator.push(
                        context,
                        UserEditScreen.route(
                            user: user,
                            onBack: () => main.userInforBloc.add(ReloadUserEvent())
                        )
                    );
                  }
              ),
              const SizedBox(width: 8,),
              getButtonMore(
                function: (){
                  Navigator.push(
                      context,
                      UserEditScreen.route(
                        user: user,
                        onBack: () => main.userInforBloc.add(ReloadUserEvent())
                      )
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }


  Widget getFriendButtons(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          getButton(
              theme: Theme.dark,
              label: "Bạn bè",
              icon: Icons.person,
              flex: 3,
              function: (){
                UserMenuBottom.showBottomMenu(
                    context: context,
                    status: UserButtonStatus.IS_FRIEND,
                    main: this
                );
              }
          ),
          const SizedBox(width: 8,),
          getButtonMessage(theme: Theme.blue),
          const SizedBox(width: 8,),
          getButtonMore(),
        ],
      ),
    );
  }

  Widget getSendButtons(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          getButton(
              theme: Theme.dark,
              label: "Đã gửi lời mời",
              icon: Icons.person,
              flex: 3,
              function: (){
                UserMenuBottom.showBottomMenu(
                    context: context,
                    status: UserButtonStatus.REQUESTING,
                    main: this
                );
              }
          ),
          const SizedBox(width: 8,),
          getButtonMessage(theme: Theme.blue),
          const SizedBox(width: 8,),
          getButtonMore(),
        ],
      ),
    );
  }

  Widget getReceiveButtons(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          getButton(
              theme: Theme.blue,
              label: "Trả lời",
              icon: Icons.person,
              flex: 3,
              function: (){
                UserMenuBottom.showBottomMenu(
                    context: context,
                    status: UserButtonStatus.REQUESTED,
                    main: this
                );
              }
          ),
          const SizedBox(width: 8,),
          getButtonMessage(theme: Theme.dark),
          const SizedBox(width: 8,),
          getButtonMore(),
        ],
      ),
    );
  }

  Widget getNotRelativeButtons(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          getButton(
              theme: Theme.blue,
              label: "Thêm bạn bè",
              icon: Icons.person_add_alt_1,
              flex: 3,
              function: (){ userButtonsBloc.add(SendRequestFriendEvent()); }
          ),
          const SizedBox(width: 8,),
          getButtonMessage(theme: Theme.dark),
          const SizedBox(width: 8,),
          getButtonMore()
        ],
      ),
    );
  }

  Widget getButton({
    Theme theme = Theme.dark,
    String? label,
    IconData icon = Icons.add,
    int flex = 3,
    void Function()? function
  }) {
    return Expanded(
        flex: flex,
        child: GestureDetector(
          onTap: function ?? (){},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: theme == Theme.dark ? Colors.black12 : Colors.blue,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: theme == Theme.dark ? Colors.black : Colors.white,
                ),
                const SizedBox(width: 4,),
                Text(label ?? "", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: theme == Theme.dark ? Colors.black : Colors.white,
                ))
              ],
            ),
          ),
        )
    );
  }

  Widget getButtonMore({
    Theme theme = Theme.dark,
    void Function()? function,
  }){
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: function ?? (){},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: theme == Theme.dark ? Colors.black12 : Colors.blue,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.more_horiz,
                  color: theme == Theme.dark ? Colors.black : Colors.white,
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget getButtonMessage({
    Theme theme = Theme.dark
  }){
    return getButton(
      theme: theme,
      label: "Nhắn tin",
      function: (){
        if (user.isMe) return;
        Navigator.push(
          main.context,
          MaterialPageRoute(
              builder: (context){
                return ChatDetailScreen(
                  partner: Partner(
                      id: user.id,
                      avatar: user.avatar,
                      username: user.username
                  ),
                );
              }
          )
        );
      },
      icon: Icons.message,
      flex: 3
    );
  }
}

