


import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';

import 'package:facebook_auth/screen/user_screen/user_friend/user_friend_bloc/user_friend_event.dart';
import 'package:facebook_auth/screen/user_screen/user_friend/user_friend_bloc/user_friend_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFriendBloc extends Bloc<UserFriendEvent, UserFriendState>{
  FriendRepository friendRepository;
  ListFriend listFriend = ListFriend();
  // String user_id;

  UserFriendBloc({
    required this.friendRepository,
  }) : super(LoadingFriendState()){
    on<LoadFriendEvent>(loadFriend);
  }

  Future<void> loadFriend(LoadFriendEvent event, Emitter<UserFriendState> emit) async {
    emit(LoadingFriendState());
    ResponseListFriend? reponseListFriend = await friendRepository.getUserFriends(event.user_id, 1);
    if (reponseListFriend == null || reponseListFriend.code != "1000"){
      return;
    }
    listFriend.copyFrom(reponseListFriend.data!);
    emit(LoadedFriendState());
  }

}

