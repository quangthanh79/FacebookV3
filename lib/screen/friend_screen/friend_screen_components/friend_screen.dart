

// ignore: must_be_immutable
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_event.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_state.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_body.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_loading.dart';
import 'package:facebook_auth/screen/friend_screen/friend_screen_components/friend_body/friend_nofriends.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
abstract class FriendScreen extends StatefulWidget{
  User user;
  FriendScreen({super.key, required this.user});
}

abstract class FriendScreenState<T extends FriendScreen> extends State<T> with AutomaticKeepAliveClientMixin{
  late User user;
  late ListFriend listFriend;
  late FriendListBloc friendListBloc;
  @override void initState(){
    super.initState();
    user = widget.user;
    listFriend = ListFriend(list: [], total: 0);
    friendListBloc = FriendListBloc(
        user: user,
        listFriend: listFriend,
        friendRepository: getIt<FriendRepository>()
    );
  }

  @override Widget build(BuildContext context){
    super.build(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'OpenSans', platform: TargetPlatform.iOS, backgroundColor: Colors.black12),
        home: Scaffold(
            resizeToAvoidBottomInset: true,
            body: BlocProvider<FriendListBloc>(
                create: (context) => friendListBloc,
                child: BlocBuilder<FriendListBloc, FriendListState>(
                    bloc: friendListBloc,
                    builder: (context, state){
                      Widget content;
                      switch(state.status){
                        case FriendListStatus.LOADING:
                          content = FriendLoading(main: this);
                          break;
                        case FriendListStatus.LOADED:
                          content = FriendBody(main: this);
                          break;
                        case FriendListStatus.NO_FRIENDS:
                          content = FriendNoFriends(main: this);
                          break;
                        default:
                          content = FriendLoading(main: this);
                          break;
                      }
                      return content;
                    }
                )
            )
        )
    );
  }

  void back(){
    Navigator.pop(context);
  }
  @override get wantKeepAlive => true;
}

// ignore: must_be_immutable
abstract class FriendScreenComponent extends StatefulWidget{
  late FriendScreenState main;
  late User user;
  FriendScreenComponent({super.key, required this.main}){
    user = main.user;
  }
}

abstract class FriendScreenComponentState<T extends FriendScreenComponent> extends State<T> with AutomaticKeepAliveClientMixin{
  late FriendScreenState main;
  late User user;
  @override void initState(){
    super.initState();
    user = widget.user;
    main = widget.main;
  }
  void back(){
    main.back();
  }

  @override get wantKeepAlive => true;
}

