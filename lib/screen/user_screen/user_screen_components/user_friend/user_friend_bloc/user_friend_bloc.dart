
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_friend_event.dart';
part 'user_friend_state.dart';

class UserFriendBloc extends Bloc<UserFriendEvent, UserFriendState>{
  FriendRepository friendRepository;
  late ListFriend listFriend;
  User user;
  // String user_id;

  UserFriendBloc({
    required this.friendRepository,
    required this.user,
    required this.listFriend
  }) : super(LoadingFriendState()){
    on<LoadFriendEvent>(loadFriend);
    on<ReloadFriendEvent>(reloadFriend);
  }

  Future<void> loadFriend(LoadFriendEvent event, Emitter<UserFriendState> emit) async {
    emit(LoadingFriendState());
    ResponseListFriend? reponseListFriend = await friendRepository.getUserFriends(user.id!, 1);
    if (reponseListFriend == null || reponseListFriend.code != "1000"){
      return;
    }
    listFriend.copyFrom(reponseListFriend.data!);
    emit(LoadedFriendState());
  }

  Future<void> reloadFriend(ReloadFriendEvent event, Emitter<UserFriendState> emit) async {
    emit(LoadedFriendState());
  }

}

