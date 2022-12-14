

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/screen/user_screen/user_avatar/user_buttons_bloc/user_buttons_event.dart';
import 'package:facebook_auth/screen/user_screen/user_avatar/user_buttons_bloc/user_buttons_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserButtonsBloc extends Bloc<UserButtonsEvent, UserButtonsState>{
  UserRepository userRepository = UserRepository();
  FriendRepository friendRepository;
  User user;

  UserButtonsBloc({
    required this.friendRepository,
    required this.user
  }) : super(UserButtonsState(userButtonStatus: UserButtonStatus.INITIAL)){
    on<SendRequestFriendEvent>(sendRequestFriend);
    on<CancelRequestFriendEvent>(cancelRequestFriend);
    on<AcceptRequestFriendEvent>(acceptRequestFriend);
    on<CancelFriendEvent>(cancelFriend);
    on<InitButtonsEvent>(initButtons);
    on<UpdateButtonsEvent>(updateButtons);
  }

  Future<void> sendRequestFriend(
      SendRequestFriendEvent e,
      Emitter<UserButtonsState> emit) async{
    if (user.is_friend == null || user.is_friend != "NOT_FRIEND") return;
    emit(UserButtonsState(userButtonStatus: UserButtonStatus.REQUESTING));
    bool? okay = await friendRepository.setRequestFriend(user.id!);
    if (okay){
      user.is_friend = "REQUESTED";
    } else {
      emit(UserButtonsState(userButtonStatus: UserButtonStatus.NOT_FRIEND));
    }
    // add(UpdateButtonsEvent());
  }
  Future<void> cancelRequestFriend(
      CancelRequestFriendEvent e,
      Emitter<UserButtonsState> emit) async{
    if (user.is_friend == null || user.is_friend != "REQUESTED") return;
    user.is_friend = "NOT_FRIEND";
    emit(UserButtonsState(userButtonStatus: UserButtonStatus.NOT_FRIEND));
    bool? okay = await friendRepository.setRequestFriend(user.id!);
    if (okay) {
      user.is_friend = "NOT_FRIEND";
    } else {
      emit(UserButtonsState(userButtonStatus: UserButtonStatus.REQUESTING));
    }
    // add(UpdateButtonsEvent());
  }
  Future<void> acceptRequestFriend(
      AcceptRequestFriendEvent e,
      Emitter<UserButtonsState> emit) async{
    if (user.is_friend == null || user.is_friend != "REQUESTING") return;
    if (e.code == Acceptable.ACCEPT){
      emit(UserButtonsState(userButtonStatus: UserButtonStatus.IS_FRIEND));
    } else {
      emit(UserButtonsState(userButtonStatus: UserButtonStatus.NOT_FRIEND));
    }
    bool? okay = await friendRepository.setAcceptFriend(user.id!, e.code == Acceptable.ACCEPT);
    if (okay) {
      if (e.code == Acceptable.ACCEPT) {
        user.is_friend = "IS_FRIEND";
      } else {
        user.is_friend = "NOT_FRIEND";
      }
    } else {
      emit(UserButtonsState(userButtonStatus: UserButtonStatus.REQUESTED));
    }
    // add(UpdateButtonsEvent());
  }

  Future<void> cancelFriend(
      CancelFriendEvent e,
      Emitter<UserButtonsState> emit) async{
    if (user.is_friend == null || user.is_friend != "IS_FRIEND") return;
    emit(UserButtonsState(userButtonStatus: UserButtonStatus.NOT_FRIEND));
    bool? okay = await friendRepository.setRequestFriend(user.id!);
    if (okay) {
      user.is_friend = "NOT_FRIEND";
    } else {
      emit(UserButtonsState(userButtonStatus: UserButtonStatus.IS_FRIEND));
    }
    // add(UpdateButtonsEvent());
  }

  Future<void> initButtons(
      InitButtonsEvent e,
      Emitter<UserButtonsState> emit) async{
    emit(getState());
  }

  Future<void> updateButtons(
      UpdateButtonsEvent e,
      Emitter<UserButtonsState> emit) async{
    ResponseUser? responseUser = await userRepository.getUserInfor(user.id!);
    if (responseUser != null && responseUser.code == "1000"){
      user.copyFrom(responseUser.data!);
      emit(getState());
    }
  }

  UserButtonsState getState(){
    UserButtonStatus status = UserButtonStatus.INITIAL;
    if (user.isMe) {
      status = UserButtonStatus.ME;
    } else {
      switch (user.is_friend) {
        case "NOT_FRIEND":
          status = UserButtonStatus.NOT_FRIEND;
          break;
        case "IS_FRIEND":
          status = UserButtonStatus.IS_FRIEND;
          break;
        case "REQUESTED":
          status = UserButtonStatus.REQUESTING;
          break;
        case "REQUESTING":
          status = UserButtonStatus.REQUESTED;
          break;
        case null:
          status = UserButtonStatus.INITIAL;
          break;
      }
    }

    return UserButtonsState(userButtonStatus: status);
  }

}


