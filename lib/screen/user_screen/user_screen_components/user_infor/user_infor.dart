

import 'package:facebook_auth/screen/user_screen/user_edit/user_edit_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_event.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserInfor extends UserScreenComponent {
  UserInfor({super.key, required super.main});

  @override
  State<StatefulWidget> createState() => UserInforState();
}

class UserInforState extends UserScreenComponentState<UserInfor>{
  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: const Text("Chi tiết",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19
            ),
          ),
        ),
        user.city != null ? getItem(
            icon: Icons.home_repair_service,
            label: "",
            value: user.city
        ) : Container(),
        user.address != null ? getItem(
            icon: Icons.home,
            label: "Sống tại ",
            value: user.address
        ) : Container(),
        user.country != null ? getItem(
            icon: Icons.location_on,
            label: "Đến từ ",
            value: user.country
        ) : Container(),
        user.link != null ? getItem(
            icon: Icons.link_rounded,
            value: user.link
        ) : Container(),
        getItem(
            icon: Icons.access_time_filled_sharp,
            label: "Tham gia vào ",
            value: user.join
        ),
        getItem(
            icon: Icons.person,
            label: "Có ",
            value: "${user.listing ?? 0} bạn bè"
        ),
        user.isMe ? GestureDetector(
          onTap: () => Navigator.push(
              context,
              UserEditScreen.route(
                user: user,
                onBack: () => main.userInforBloc.add(ReloadUserEvent())
            )
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.withOpacity(0.25),

            ),
            alignment: Alignment.center,
            child: Text(
              "Chỉnh sửa chi tiết công khai",
              style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ) : GestureDetector(
            child: getItem(
                icon: Icons.more_horiz,
                label: "Xem thông tin giới thiệu của ",
                value: user.username ?? "Người dùng facebook"
            ),
            onTap: (){}
        ),
        const SizedBox(height: 8,)
      ],
    );
  }

  Widget getItem({
    String? label = "",
    String? value = "",
    IconData? icon = Icons.add,
  }){
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey,),
            const SizedBox(width: 8,),
            Expanded(
              child: Text.rich(TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: label ?? "",
                        style: const TextStyle(
                          fontSize: 15
                        )
                    ),
                    TextSpan(
                        text: value ?? "",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        )
                    ),
                  ],
                ),
              )
            )
          ],
        )
    );
  }
}
