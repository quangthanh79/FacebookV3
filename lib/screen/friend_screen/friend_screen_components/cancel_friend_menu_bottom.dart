

import 'package:facebook_auth/screen/user_screen/user_screen_components/menu_bottom.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CancelFriendMenuBottom extends MenuBottom{
  void Function()? onSuccess;
  CancelFriendMenuBottom({
    super.key,
    required super.bottomMenuContext,
    this.onSuccess
  });

  static void showBottomMenu({
    required BuildContext context,
    void Function()? onSuccess
  }){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context){
          return CancelFriendMenuBottom(
            bottomMenuContext: context,
            onSuccess: onSuccess,
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return getFrame(
      children: [
        getRow(
            icon: Icons.person_off,
            label: "Hủy kết bạn",
            function: onSuccess ?? (){}
        ),
      ]
    );
  }

}
