

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/edit_avatar.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/edit_bloc/edit_bloc.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/edit_infor.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_event.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// ignore: must_be_immutable
class UserEditScreen extends StatelessWidget with MyPage{
  User user;
  User tempUser = User();
  // UserScreen main;
  bool isChanged = false;
  BlocSystem? blocSystem;
  String? output;

  UserEditScreen({
    super.key,
    required this.user
  }){
    user = user;
    tempUser.copyFrom(user);
    blocSystem = BlocSystem(user: user, userRepository: getIt.get<UserRepository>());
  }



  static Route<void> route(User user) {
    return MaterialPageRoute(
        builder: (context) {
          return UserEditScreen(
              user: user
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'OpenSans', platform: TargetPlatform.iOS, backgroundColor: Colors.black12),
        home: Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<EditUsernameBloc>(create: (context) => blocSystem!.usernameBloc!),
                BlocProvider<EditAvatarBloc>(create: (context) => blocSystem!.avatarBloc!),
                BlocProvider<EditCoverImageBloc>(create: (context) => blocSystem!.coverImageBloc!),
                BlocProvider<EditDescriptionBloc>(create: (context) => blocSystem!.descriptionBloc!),
                BlocProvider<EditCountryBloc>(create: (context) => blocSystem!.countryBloc!),
                BlocProvider<EditAddressBloc>(create: (context) => blocSystem!.addressBloc!),
                BlocProvider<EditCityBloc>(create: (context) => blocSystem!.cityBloc!),
                BlocProvider<EditLinkBloc>(create: (context) => blocSystem!.linkBloc!),
              ],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),
                  Header(
                    label: "Chỉnh sửa trang cá nhân",
                    main: this,
                  ),
                  Expanded(
                      flex: 1,
                      child: ListView(
                          padding: const EdgeInsets.all(0),
                          children: [
                            EditUsername(
                                main: this
                            ),
                            EditAvatar(
                              main: this,
                            ),
                            EditCoverImage(
                              main: this,
                            ),
                            EditDescription(
                                main: this
                            ),
                            EditInformation(
                                main: this
                            ),
                            const SizedBox(height: 48,),
                          ]
                      )
                  )
                ],
              ),
            )
        )
    );
  }

  @override
  void back(){
    // if (isChanged) {
    //   main.userInforBloc!.add(LoadUserEvent());
    // }


    // main.userInforBloc!.add(LoadUserEvent());
    // Navigator.pop(context!);
  }
}

// ignore: must_be_immutable
mixin MyPage{
  BuildContext? context;
  void back(){
    if (context == null) return;
    Navigator.pop(context!);
  }
}

class MyDivider extends SizedBox{
  MyDivider({super.key}) : super(
    height: 1,
    child: Container(
      decoration: const BoxDecoration(
          color: Colors.black12
      ),
    )
  );
}

// ignore: must_be_immutable
class Header extends StatelessWidget{
  String label = "";
  MyPage main;
  Header({super.key, String? label, required this.main}){
    this.label = label ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 1.0,
                color: Colors.grey
            )
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 6,
              child: Row(
                children: [
                  GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Icon(Icons.arrow_back),
                    ),
                    onTap: () => main.back(),
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              )
          ),
          Expanded(
              flex: 2,
              child: Container()
          )
        ],
      ),
    );
  }
}

