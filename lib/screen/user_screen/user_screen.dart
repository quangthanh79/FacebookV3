
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_body/user_body.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_bloc.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_event.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_state.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_body/user_loading.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_friend/user_friend_bloc/user_friend_bloc.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/user_friend/user_friend_bloc/user_friend_event.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

// ignore: must_be_immutable
class UserScreen extends StatefulWidget{
  late User user;

  UserScreen({super.key, User? user}){
    if (user?.id == null){
      this.user = User(id: SessionUser.idUser);
    } else {
      this.user = user!;
    }
  }

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => UserScreenState(user: user);

  static Route<void> route({
    required User? user,
  }) {
    return MaterialPageRoute(
        builder: (context) =>  UserScreen(
            user: user
        )
    );
  }

  static Route<void> routeReady({required UserScreen userScreen}){
    return MaterialPageRoute(
        builder: (context) => userScreen
    );
  }
}

class UserScreenState extends State<UserScreen>{
  User user;
  ListFriend listFriend = ListFriend(list: [], total: 0);
  late UserInforBloc userInforBloc;
  late UserFriendBloc userFriendBloc;

  UserScreenState({required this.user}) {
    
    userInforBloc = UserInforBloc(
        userRepository: getIt<UserRepository>(),
        // friendRepository: getIt<FriendRepository>(),
        user: user,
        // listFriend: listFriend
    )..add(LoadUserEvent());

    userFriendBloc = UserFriendBloc(
        friendRepository: getIt<FriendRepository>(),
        user: user,
        listFriend: listFriend
    )..add(LoadFriendEvent());
  }

  @override void initState(){
    super.initState();
  }

  // @override void dispose(){
  //   userInforBloc.close();
  //   userFriendBloc.close();
  //   super.dispose();
  // }

  Future<void> refresh() async {
    userInforBloc.add(BackgroundLoadUserEvent());
    userFriendBloc.add(LoadFriendEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'OpenSans', platform: TargetPlatform.iOS, backgroundColor: Colors.black12),
      home: Scaffold(
          resizeToAvoidBottomInset: true,
          body: BlocProvider<UserInforBloc>(
            create: (context) => userInforBloc,
            child: BlocBuilder<UserInforBloc, UserInforState>(
                bloc: userInforBloc,
                builder: (context, state){
                  Widget content;
                  switch(state.statusLoadInfo){
                    case FormzStatus.submissionInProgress:
                      content = UserLoading(main: this);
                      break;
                    case FormzStatus.submissionSuccess:
                      content = UserBody(main: this);
                      break;
                    case FormzStatus.submissionFailure:
                      content = UserBody(main: this);
                      break;
                    default:
                      content = UserLoading(main: this);
                      break;
                  }
                  return content;
                }
            )
        )
      )
    );
  }
}


// ignore: must_be_immutable
abstract class UserScreenComponent extends StatefulWidget{
  late UserScreenState main;
  late User user;
  UserScreenComponent({super.key, required this.main}){
    user = main.user;
  }
}

abstract class UserScreenComponentState<T extends UserScreenComponent> extends State<T>{
  late User user;
  late UserScreenState main;
  @override void initState(){
    super.initState();
    user = widget.user;
    main = widget.main;
  }
  void back(){
    Navigator.pop(main.context);
  }
}


