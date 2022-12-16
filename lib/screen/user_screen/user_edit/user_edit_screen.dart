

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/edit_avatar.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/edit_bloc/edit_bloc.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/edit_infor.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_bloc/edit_state.dart';


// ignore: must_be_immutable
class UserEditScreen extends MyPage{
  User user;
  UserEditScreen({
    required this.user,
    super.onBack,
    super.onBackResponse,
    super.key
  });

  @override
  State<StatefulWidget> createState() => UserEditScreenState();

  static Route<void> route({
    required User user,
    void Function()? onBack,
    void Function(String?)? onBackResponse
  }) {
    return MaterialPageRoute(
        builder: (context) {
          return UserEditScreen(
            user: user,
            onBack: onBack,
            onBackResponse: onBackResponse,
          );
        }
    );
  }
}

// ignore: must_be_immutable
class UserEditScreenState extends MyPageState<UserEditScreen>{
  late User user;
  User tempUser = User();
  bool isChanged = false;
  late BlocSystem blocSystem;

  @override
  void initState(){
    super.initState();
    user = widget.user;
    tempUser.copyFrom(user);
    blocSystem = BlocSystem(
        user: user,
        userRepository: getIt<UserRepository>()
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'OpenSans', platform: TargetPlatform.iOS, backgroundColor: Colors.black12),
        home: Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<EditUsernameBloc>(create: (context) => blocSystem.usernameBloc),
                BlocProvider<EditAvatarBloc>(create: (context) => blocSystem.avatarBloc),
                BlocProvider<EditCoverImageBloc>(create: (context) => blocSystem.coverImageBloc),
                BlocProvider<EditDescriptionBloc>(create: (context) => blocSystem.descriptionBloc),
                BlocProvider<EditCountryBloc>(create: (context) => blocSystem.countryBloc),
                BlocProvider<EditAddressBloc>(create: (context) => blocSystem.addressBloc),
                BlocProvider<EditCityBloc>(create: (context) => blocSystem.cityBloc),
                BlocProvider<EditLinkBloc>(create: (context) => blocSystem.linkBloc),
              ],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),
                  Header(
                    label: "Chỉnh sửa trang cá nhân",
                    back: back,
                  ),
                  Expanded(
                      flex: 1,
                      child: ListView(
                          addAutomaticKeepAlives: true,
                          padding: const EdgeInsets.all(0),
                          children: [
                            BlocBuilder<EditUsernameBloc, EditState>(
                                builder: (context, state) => EditUsername(main: this)
                            ),
                            BlocBuilder<EditAvatarBloc, EditState>(
                                builder: (context, state) => EditAvatar(main: this)
                            ),
                            BlocBuilder<EditCoverImageBloc, EditState>(
                                builder: (context, state) => EditCoverImage(main: this)
                            ),
                            BlocBuilder<EditDescriptionBloc, EditState>(
                                builder: (context, state) => EditDescription(main: this)
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
}

// ignore: must_be_immutable
abstract class MyPage extends StatefulWidget{
  void Function()? onBack;
  void Function(String?)? onBackResponse;
  String? response;
  MyPage({this.onBack, this.onBackResponse, super.key});
  void back(){
    if (onBack != null){
      onBack!();
    }
    if (onBackResponse != null){
      onBackResponse!(response);
    }
  }
}
abstract class MyPageState<T extends MyPage> extends State<T>{
  void back(){
    widget.back();
    Navigator.pop(context);
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
  void Function()? back;
  Header({super.key, String? label, this.back}){
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
                    onTap: back ?? (){},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Icon(Icons.arrow_back),
                    ),
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
        ],
      ),
    );
  }
}

