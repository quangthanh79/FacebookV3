

import 'dart:io';

import 'package:facebook_auth/screen/user_screen/user_edit/input_avatar_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/input_cover_image_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/input_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/user_edit_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/menu_bottom.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class EditUsername extends StatelessWidget{
  UserEditScreenState main;
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
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: (){ onChangeUsername(); },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                main.user.username ?? "Thêm tên của bạn",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: main.user.username != null ? Colors.black : Colors.black38
                                ),
                              ),
                            )
                          ]
                      )
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
    InputScreen.route(
        context: context!,
        label: "Tên",
        value: main.user.username ?? "",
        onBackResponse: (response){
          if (response != null){
            main.isChanged = true;
            main.user.username = response;
            main.blocSystem.usernameBloc.commit(main.tempUser);
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
  UserEditScreenState main;
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
                    file: main.user.avatar_file,
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
    InputAvatarScreen.route(
        context: context!,
        label: "Ảnh đại diện",
        value: main.user.avatar,
        onBackResponse: (file){
          if (file == null) return;
          main.isChanged = true;
          main.user.avatar_file = file;
          main.blocSystem.avatarBloc.commit(main.tempUser);
        }
    );
  }

  void removeAvatar(){
    // todo
  }
}


// ignore: must_be_immutable
class EditCoverImage extends StatelessWidget{
  UserEditScreenState main;
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
    InputCoverImageScreen.route(
        context: context!,
        label: "Ảnh bìa",
        value: main.user.cover_image,
        onBackResponse: (file){
          main.isChanged = true;
          main.user.cover_image_file = file;
          main.blocSystem.coverImageBloc.commit(main.tempUser);
        }
    );
  }

  void removeCoverImage(){
    // todo
  }

}

