

import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_buttons_state.dart';
part 'user_buttons_event.dart';

class UserButtonsBloc extends Bloc<UserButtonsEvent, UserButtonsState>{
  UserRepository userRepository = getIt<UserRepository>();
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
    on<BlockUserEvent>(blockUser);
    on<UnblockUserEvent>(unblockUser);
  }

  Future<void> sendRequestFriend(
      SendRequestFriendEvent e,
      Emitter<UserButtonsState> emit) async{
    if (user.is_friend == null || user.is_friend != "NOT_FRIEND") return;
    emit(UserButtonsState(userButtonStatus: UserButtonStatus.REQUESTING));
    ResponseListFriend? responseListFriend = await friendRepository.setRequestFriend(user.id!);
    if (responseListFriend != null && responseListFriend.code == "1000"){
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
    ResponseListFriend? responseListFriend = await friendRepository.setRequestFriend(user.id!);
    if (responseListFriend != null && responseListFriend.code == "1000") {
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
    ResponseListFriend? responseListFriend = await friendRepository.setAcceptFriend(user.id!, e.code == Acceptable.ACCEPT);
    if (responseListFriend != null && responseListFriend.code == "1000") {
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
    ResponseActionFriend? responseActionFriend = await friendRepository.setCancelFriend(user.id!);
    if (responseActionFriend != null && responseActionFriend.code == "1000") {
      user.is_friend = "NOT_FRIEND";
    } else {
      emit(UserButtonsState(userButtonStatus: UserButtonStatus.IS_FRIEND));
    }
    // add(UpdateButtonsEvent());
  }

  Future<void> blockUser(
      BlockUserEvent e,
      Emitter<UserButtonsState> emit) async{
    if (user.is_friend == null || user.is_friend == "BLOCKING") return;
    emit(UserButtonsState(userButtonStatus: UserButtonStatus.BLOCKING));
    ResponseActionFriend? responseActionFriend = await friendRepository.setBlock(user.id!, 0);
    if (responseActionFriend != null && responseActionFriend.code == "1000") {
      user.is_friend = "BLOCKING";
      if (e.onSuccess != null) e.onSuccess!.call();
    } else {
      emit(getState());
      if (e.onError != null) e.onError!.call();
    }
  }

  Future<void> unblockUser(
      UnblockUserEvent e,
      Emitter<UserButtonsState> emit) async{
    if (user.is_friend == null || user.is_friend != "BLOCKING") return;
    emit(UserButtonsState(userButtonStatus: UserButtonStatus.NOT_FRIEND));
    ResponseActionFriend? responseActionFriend = await friendRepository.setBlock(user.id!, 1);
    if (responseActionFriend != null && responseActionFriend.code == "1000") {
      user.is_friend = "NOT_FRIEND";
      if (e.onSuccess != null) e.onSuccess!.call();
    } else {
      emit(getState());
      if (e.onError != null) e.onError!.call();
    }
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
      user.copyFrom(responseUser.data);
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
        case "BLOCKING":
          status = UserButtonStatus.BLOCKING;
          break;
        case "BLOCKED":
          status = UserButtonStatus.BLOCKED;
          break;
        case null:
          status = UserButtonStatus.INITIAL;
          break;
      }
    }

    return UserButtonsState(userButtonStatus: status);
  }

}


