

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_avatar/user_buttons.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_avatar/user_buttons_bloc/user_buttons_bloc.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
abstract class MenuBottom extends StatelessWidget{
  BuildContext bottomMenuContext;
  MenuBottom({super.key, required this.bottomMenuContext});

  void closeBottomMenu(){
    Navigator.pop(bottomMenuContext);
  }

  Widget getFrame({
    required List<Widget> children
  }) {
    return Wrap(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)
                ),
                color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: children
            )
        )
      ],
    );
  }

  Widget getRow({
    IconData icon = Icons.person,
    String label = "",
    void Function()? function
  }){
    return GestureDetector(
        onTap: (){
          closeBottomMenu();
          if (function != null) {
            // print("call");
            function();
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(500))
                  ),
                  child: Icon(
                    icon,
                    color: Colors.black,

                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    label,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

// ignore: must_be_immutable
class UserMenuBottom extends MenuBottom{
  static void showBottomMenu({
    required BuildContext context,
    required UserButtonStatus status,
    required UserButtonsState_ main
  }){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context){
          return UserMenuBottom(
            bottomMenuContext: context,
            status: status,
            main: main,
          );
        }
    );
  }

  UserButtonsBloc? userButtonsBloc;
  User? user;
  UserButtonStatus status;
  UserButtonsState_ main;

  UserMenuBottom({
    super.key,
    required this.status,
    required super.bottomMenuContext,
    required this.main
  }) {
    userButtonsBloc = main.userButtonsBloc;
    user = main.user;
  }

  @override
  Widget build(BuildContext context) {
    // return getReceiveMenuBottom(context);
    switch (status){
      case UserButtonStatus.ME:
        return getMeMenuBottom(context);
      case UserButtonStatus.IS_FRIEND:
        return getFriendMenuBottom(context);
      case UserButtonStatus.REQUESTING:
        return getSendMenuBottom(context);
      case UserButtonStatus.REQUESTED:
        return getReceiveMenuBottom(context);
      case UserButtonStatus.NOT_FRIEND:
        return getNotRelativeMenuBottom(context);
      case UserButtonStatus.BLOCKING:
      case UserButtonStatus.BLOCKED:
        return getBlockMenuBottom(context);
      case UserButtonStatus.INITIAL:
        return Container();
    }
  }

  Widget getMeMenuBottom(BuildContext context) {
    return Container();
  }

  Widget getFriendMenuBottom(BuildContext context){
    return getFrame(
        children: [
          getRow(
              icon: Icons.person_off,
              label: "Hủy kết bạn",
              function: () => userButtonsBloc!.add(CancelFriendEvent())
          ),
        ]
    );
  }

  Widget getSendMenuBottom(BuildContext context){
    return getFrame(
        children: [
          getRow(
              icon: Icons.person_off,
              label: "Hủy lời mời",
              function: () => userButtonsBloc!.add(CancelRequestFriendEvent())
          ),
        ]
    );
  }

  Widget getBlockMenuBottom(BuildContext context){
    return getFrame(
        children: [
          getRow(
              icon: Icons.person_off,
              label: "Chặn người dùng",
              function: () => userButtonsBloc!.add(BlockUserEvent())
          ),
        ]
    );
  }


  Widget getReceiveMenuBottom(BuildContext context){
    return getFrame(
        children: [
          getRow(
              icon: Icons.person_add,
              label: "Chấp nhận",
              function: () => userButtonsBloc!.add(AcceptRequestFriendEvent(
                    code: Acceptable.ACCEPT
                ))
          ),
          getRow(
              icon: Icons.person_off,
              label: "Từ chối",
              function: () => userButtonsBloc!.add(AcceptRequestFriendEvent(
                    code: Acceptable.DECLINE
                ))
          ),
        ]
    );
  }

  Widget getNotRelativeMenuBottom(BuildContext context){
    return Container();
  }
}


// ignore: must_be_immutable
class EditMenuBottom extends MenuBottom{
  static void showBottomMenu({
    required BuildContext context,
    // required MyPage main,
    void Function()? onEdit,
    void Function()? onRemove,
    String label = "",
  }){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context){
          return EditMenuBottom(
            bottomMenuContext: context,
            // main: main,
            onEdit: onEdit,
            onRemove: onRemove,
            label: label
          );
        }
    );
  }

  void Function()? onEdit, onRemove;
  String label = "";
  EditMenuBottom({
    super.key,
    required super.bottomMenuContext,
    this.onEdit, this.onRemove,
    this.label = ""
  });

  @override
  Widget build(BuildContext context) {
    return getFrame(
      children: [
        getRow(
          icon: Icons.edit,
          label: "Chỉnh sửa $label",
          function: onEdit
        ), getRow(
          icon: Icons.delete,
          label: "Gỡ $label",
          function: onRemove
        )
      ]
    );
  }

}
