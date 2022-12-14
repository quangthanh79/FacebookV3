
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/screen/user_screen/user_body.dart';
import 'package:facebook_auth/screen/user_screen/user_components/user_loading.dart';
import 'package:facebook_auth/screen/user_screen/user_friend/user_friend_bloc/user_friend_bloc.dart';
import 'package:facebook_auth/screen/user_screen/user_friend/user_friend_bloc/user_friend_event.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_bloc.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_event.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_state.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';


// ignore: must_be_immutable
class UserScreen extends StatefulWidget{
  User? user;
  ListFriend listFriend = ListFriend(total: 0, list: []);

  UserRepository userRepository = UserRepository();
  FriendRepository friendRepository = FriendRepository();

  UserScreen({this.user});

  @override
  State<StatefulWidget> createState() => UserScreenState();

  // void back(){
  //   if (context == null) return;
  //   Navigator.pop(context!);
  // }
  static Route<void> route({
    required User? user,
  }) {
    return MaterialPageRoute(
        builder: (context) =>  UserScreen(
          user: user
        )
    );
  }
}


class UserScreenState extends State<UserScreen>{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'OpenSans', platform: TargetPlatform.iOS, backgroundColor: Colors.black12),
      home: Scaffold(
          resizeToAvoidBottomInset: true,
          body: BlocProvider<UserInforBloc>(
            create: (context) => UserInforBloc(
                userRepository: getIt.get<UserRepository>(),
                friendRepository: getIt.get<FriendRepository>(),
                user: widget.user ?? User()
            )..add(LoadUserEvent()),
            child: BlocBuilder<UserInforBloc, UserInforState>(
                // bloc: widget.userInforBloc!,
                builder: (context, state){
                  // return Text("123\n1\n2\n3");
                  Widget content;
                  switch(state.statusLoadInfo){
                    case FormzStatus.submissionInProgress:
                      content =  UserLoading(user: widget.user ?? User());
                      break;
                    case FormzStatus.submissionSuccess:
                      content =  UserBody(user: state.user?? User(),listFriend: state.listFriend ?? ListFriend(total: 0, list: []));
                      break;
                    case FormzStatus.submissionFailure:
                      content =  UserBody(user: widget.user?? User(),listFriend: ListFriend(total: 0, list: []));
                      break;
                    default:
                      content =  UserLoading(user: state.user ?? User());
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







