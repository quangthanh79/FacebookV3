
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_bloc.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_avatar/user_buttons.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class UserAvatar extends UserScreenComponent {
  UserAvatar({super.key, required super.main});
  @override
  State<StatefulWidget> createState() => UserAvatarState();
}

class UserAvatarState extends UserScreenComponentState<UserAvatar>{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getAvatar(context),
        getName(context),
        const SizedBox(height: 12,),
        UserButtons(main: main),
        const SizedBox(height: 12,)
      ],
    );
  }

  Widget getAvatar(BuildContext context){
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Stack(
              children: [
                getImage(
                  uri: user.cover_image ?? 'assets/images/default_cover_image.jpg',
                  defaultUri: 'assets/images/default_cover_image.jpg',
                  width: 1000,
                  height: 250,
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: user.isMe ? GestureDetector(
                      onTap: main.routeEditScreen,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white70
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 25,
                          ),
                        ),
                      ),
                    ) : Container()
                )
              ]
          ),
          Positioned(
              top: 100,
              left: 16,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: getImage(
                        uri: user.avatar ?? 'assets/images/default_avatar_image.jpg',
                        defaultUri: 'assets/images/default_avatar_image.jpg',
                        width: 180,
                        height: 180,
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: user.isMe ? GestureDetector(
                        onTap: main.routeEditScreen,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black12
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 25,
                            ),
                          ),
                        ),
                      ) : Container()
                  )
                ],
              )
          )
        ],
      ),
    );
  }

  Widget getName(BuildContext context){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        child: BlocBuilder<UserInforBloc, UserInforState>(
            // bloc: main.userInforBloc,
            builder: (context, state){
              String description = user.description ?? "";
              String username = user.username ?? "Người dùng facebook";
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  // ignore: unnecessary_null_comparison
                  SizedBox(height: description != null ? 8 : 0,),
                  // ignore: unnecessary_null_comparison
                  description != null ? Text(description,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ) : Container()
                ],
              );
            }
        )
    );
  }

}

