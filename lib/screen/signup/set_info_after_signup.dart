

import 'dart:io';

import 'package:facebook_auth/blocs/sign_up/change_info_after_signup/change_info_after_signup_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/my_button_style.dart';
import 'package:facebook_auth/screen/main_facebook.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:facebook_auth/utils/widget/appbar_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/user_info.dart';

class SetInfoAfterSignup extends StatefulWidget{
  const SetInfoAfterSignup({super.key});
  @override
  State<StatefulWidget> createState() => SetInfoAfterSignupState();
}

class SetInfoAfterSignupState extends State<SetInfoAfterSignup>{
  late ChangeInfoAfterSignupBloc changeInfoBloc;
  TextEditingController controller = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  late User user;

  void chooseImage({required ImageSource imageSource}) async {
    XFile? image = await imagePicker.pickImage(source: imageSource);
    if (image != null){
      user.avatar_file = File(image.path);
      changeInfoBloc.add(ReloadState());
    }
  }

  @override void initState(){
    super.initState();
    user = User(username: "");
    changeInfoBloc = ChangeInfoAfterSignupBloc(user: user);
    changeInfoBloc.add(ReloadState());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    return BlocProvider<ChangeInfoAfterSignupBloc>(
        create: (context) => changeInfoBloc,
        child: BlocBuilder<ChangeInfoAfterSignupBloc, ChangeInfoAfterSignupState>(
          bloc: changeInfoBloc,
          builder: (context, state) {
            print("rebuild");
            if (state.status == ChangeInfoAfterSignupStatus.SUCCESS){
              return Success(context);
            }
            return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                body: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: SafeArea(
                      top: true,
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getAppBar2(context, "Cài đặt thông tin cho tài khoản của bạn"),
                              Expanded(
                                flex: 1,
                                child: ListView(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 20,),
                                          getUsername(context, state),
                                          const SizedBox(height: 30,),
                                          getAvatar(context, state),
                                          const SizedBox(height: 40,),
                                          getButton(context, state)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]
                          )
                      )
                  ),
                )
            );
          }
        )
    );
  }

  Widget getUsername(BuildContext context, ChangeInfoAfterSignupState state){
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Tên tài khoản",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue,
                        width: 1
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8))
                ),
                constraints: const BoxConstraints(
                  maxHeight: 80
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: "Nhập tên tài khoản",
                    border: InputBorder.none,
                    errorText: state.status == ChangeInfoAfterSignupStatus.WRONG_USERNAME ? state.message : ""
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  maxLength: 100,
                  onSubmitted: (text){
                    controller.text = text;
                  },
                  onChanged: (text){
                    user.username = text;
                    changeInfoBloc.add(ChangeUsername());
                  },
                ),
              )
            )
          ],
        )
      ],
    );
  }

  Widget getAvatar(BuildContext context, ChangeInfoAfterSignupState state){
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Chọn ảnh đại diện",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){ chooseImage(imageSource: ImageSource.gallery); },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10000),
                    border: Border.all(color: Colors.blue, width: 5)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: getImage(
                    file: user.avatar_file,
                    defaultUri: 'assets/images/default_avatar_image.jpg',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            )
          ],
        )
      ]
    );
  }

  Widget getButton(BuildContext context, ChangeInfoAfterSignupState state){
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: state.status == ChangeInfoAfterSignupStatus.OKAY ?
                    () => changeInfoBloc.add(Submit(context: context))
                    : null,
                style: MyButtonStyle(
                    padding: const EdgeInsets.symmetric(vertical: 12,),
                    backgroundColor: Colors.blue,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text("Lưu",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),
                        )
                      )
                    )
                  ],
                ),
            ),
          ),
        )
      ],
    );
  }

  Widget Success(BuildContext context){
    navigateLate(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            top: true,
            child: Center(
                child: Column(
                    children: [
                      getAppBar2(context, "Đổi thông tin thành công"),
                      const SizedBox(height: 250,),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 30,),
                      const Text(
                          "Đang chuyển hướng...",
                          style: TextStyle(
                            color: AppTheme.grey800,
                            fontFamily: 'OpenSans',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,)
                      ),
                    ]
                )
            )
        )
    );
  }

  void navigateLate(BuildContext context) async{
    Future.delayed(const Duration(seconds: 5), (){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MainFacebookScreen(),
          ),
              (Route<dynamic> route) => false
      );
    });
  }
}

