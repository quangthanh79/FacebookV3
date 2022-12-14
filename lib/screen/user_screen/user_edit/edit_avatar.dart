

import 'package:facebook_auth/screen/user_screen/user_avatar/user_avatar.dart';
import 'package:facebook_auth/screen/user_screen/user_components/menu_bottom.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/edit_bloc/edit_event.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/input_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/user_edit_screen.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class EditUsername extends StatelessWidget{
  UserEditScreen main;
  BuildContext? context;

  EditUsername({super.key, required this.main});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
        margin: const EdgeInsets.only(
            left: 12,
            right: 12
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyDivider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                    "Tên",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20
                    )
                ),
                GestureDetector(
                    onTap: (){ onChangeUsername(); },
                    child: Text(
                      main.user.username == null ? "Thêm" : "Chỉnh sửa",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.blue.shade700
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){ onChangeUsername(); },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            main.user.username ?? "Thêm tên của bạn",
                            style: TextStyle(
                                fontSize: 20,
                                color: main.user.username != null ? Colors.black : Colors.black38
                            ),
                          )
                        ]
                    )
                )
              ],
            ),
            const SizedBox(height: 16,),
            MyDivider()
          ],
        )
    );
  }

  void onChangeUsername(){
    if (main.user.username != null){
      EditMenuBottom.showBottomMenu(
          context: context!,
          onEdit: changeUsername,
          onRemove: removeUsername,
          label: "Tên (username)"
      );
    } else {
      changeUsername();
    }
  }

  void changeUsername() {
    InputScreen.show(
        context: context!,
        main: main,
        label: "Tên",
        value: main.user.username ?? "",
        callback: (){
          if (main.output != null){
            main.isChanged = true;
            main.user.username = main.output;
            // print(main.main.user!.username);
            main.blocSystem!.usernameBloc!.add(CommitChangeEvent());
          }
        }
    );
  }

  void removeUsername(){
    // not allow to remove username
  }
}

// ignore: must_be_immutable
class EditAvatar extends StatelessWidget{
  UserEditScreen main;
  BuildContext? context;

  EditAvatar({super.key, required this.main});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      margin: const EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Ảnh đại diện",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20
                )
              ),
              GestureDetector(
                onTap: (){ onChangeAvatar(); },
                child: Text(
                  main.user.avatar == null ? "Thêm" : "Chỉnh sửa",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.blue.shade700
                  ),
                )
              )
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){ onChangeAvatar(); },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: getImage(
                    uri: main.user.avatar,
                    defaultUri: 'assets/images/default_avatar_image.jpg',
                    width: 150,
                    height: 150,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16,),
          MyDivider()
        ],
      )
    );
  }

  void onChangeAvatar(){
    if (main.user.avatar != null){
      EditMenuBottom.showBottomMenu(
          context: context!,
          onEdit: changeAvatar,
          onRemove: removeAvatar,
          label: "Ảnh đại diện"
      );
    } else {
      changeAvatar();
    }
  }

  void changeAvatar(){
    // to do
  }

  void removeAvatar(){
    // to do
  }
}


// ignore: must_be_immutable
class EditCoverImage extends StatelessWidget{
  UserEditScreen main;
  BuildContext? context;

  EditCoverImage({super.key, required this.main});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
        margin: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                    "Ảnh bìa",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20
                    )
                ),
                GestureDetector(
                    onTap: (){ onChangeCoverImage(); },
                    child: Text(
                      main.user.cover_image == null ? "Thêm" : "Chỉnh sửa",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.blue.shade700
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){ onChangeCoverImage(); },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: getImage(
                        uri: main.user.cover_image,
                        defaultUri: 'assets/images/default_cover_image.jpg',
                        width: 1000,
                        height: 220
                    ),
                  )
                )
              ],
            ),
            const SizedBox(height: 16,),
            MyDivider()
          ],
        )
    );
  }

  void onChangeCoverImage(){
    if (main.user.cover_image != null){
      EditMenuBottom.showBottomMenu(
          context: context!,
          onEdit: changeCoverImage,
          onRemove: removeCoverImage,
          label: "Ảnh bìa"
      );
    } else {
      changeCoverImage();
    }
  }

  void changeCoverImage(){
    // todo
  }

  void removeCoverImage(){
    // todo
  }

}

