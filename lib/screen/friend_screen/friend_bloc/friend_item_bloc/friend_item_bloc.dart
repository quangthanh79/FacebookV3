

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_item_bloc/friend_item_event.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_item_bloc/friend_item_state.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendItemBloc extends Bloc<FriendItemEvent, FriendItemState>{
  User user;
  UserRepository userRepository = getIt<UserRepository>();
  FriendRepository friendRepository;
  FriendItemBloc({required this.user, required this.friendRepository})
  :super(FriendItemState(status: FriendItemStatus.INITIAL)){
    on<SendRequestEvent>(sendRequestFriend);
    on<CancelRequestEvent>(cancelRequestFriend);
    on<AcceptRequestEvent>(acceptRequestFriend);
    on<CancelFriendEvent>(cancelFriend);
    on<InitButtonsEvent>(initButtons);
    on<UpdateButtonsEvent>(updateButtons);
  }

  Future<void> sendRequestFriend(SendRequestEvent e, Emitter<FriendItemState> emit) async{
    if (user.is_friend == null || user.is_friend != "NOT_FRIEND") return;
    emit(FriendItemState(status: FriendItemStatus.REQUESTING));
    bool? okay = await friendRepository.setRequestFriend(user.id!);
    if (okay){
      user.is_friend = "REQUESTED";
    } else {
      emit(FriendItemState(status: FriendItemStatus.NOT_FRIEND));
    }
  }
  Future<void> cancelRequestFriend(CancelRequestEvent e, Emitter<FriendItemState> emit) async{
    if (user.is_friend == null || user.is_friend != "REQUESTED") return;
    user.is_friend = "NOT_FRIEND";
    emit(FriendItemState(status: FriendItemStatus.NOT_FRIEND));
    bool? okay = await friendRepository.setRequestFriend(user.id!);
    if (okay) {
      user.is_friend = "NOT_FRIEND";
    } else {
      emit(FriendItemState(status: FriendItemStatus.REQUESTING));
    }
  }
  Future<void> acceptRequestFriend(AcceptRequestEvent e, Emitter<FriendItemState> emit) async{
    if (user.is_friend == null || user.is_friend != "REQUESTING") return;
    if (e.code == Acceptable.ACCEPT){
      emit(FriendItemState(status: FriendItemStatus.IS_FRIEND));
    } else {
      emit(FriendItemState(status: FriendItemStatus.NOT_FRIEND));
    }
    bool? okay = await friendRepository.setAcceptFriend(user.id!, e.code == Acceptable.ACCEPT);
    if (okay) {
      if (e.code == Acceptable.ACCEPT) {
        user.is_friend = "IS_FRIEND";
      } else {
        user.is_friend = "NOT_FRIEND";
      }
    } else {
      emit(FriendItemState(status: FriendItemStatus.REQUESTED));
    }
  }
  Future<void> cancelFriend(CancelFriendEvent e, Emitter<FriendItemState> emit) async{
    if (user.is_friend == null || user.is_friend != "IS_FRIEND") return;
    emit(FriendItemState(status: FriendItemStatus.NOT_FRIEND));
    bool? okay = await friendRepository.setRequestFriend(user.id!);
    if (okay) {
      user.is_friend = "NOT_FRIEND";
    } else {
      emit(FriendItemState(status: FriendItemStatus.IS_FRIEND));
    }
  }
  Future<void> initButtons(InitButtonsEvent e, Emitter<FriendItemState> emit) async{
    emit(getState());
  }
  Future<void> updateButtons(UpdateButtonsEvent e, Emitter<FriendItemState> emit) async{
    ResponseUser? responseUser = await userRepository.getUserInfor(user.id!);
    if (responseUser != null && responseUser.code == "1000"){
      user.copyFrom(responseUser.data!);
      emit(getState());
    }
  }

  FriendItemState getState(){
    FriendItemStatus status = FriendItemStatus.INITIAL;
    if (user.isMe) {
      status = FriendItemStatus.ME;
    } else {
      switch (user.is_friend) {
        case "NOT_FRIEND":
          status = FriendItemStatus.NOT_FRIEND;
          break;
        case "IS_FRIEND":
          status = FriendItemStatus.IS_FRIEND;
          break;
        case "REQUESTED":
          status = FriendItemStatus.REQUESTING;
          break;
        case "REQUESTING":
          status = FriendItemStatus.REQUESTED;
          break;
        case null:
          status = FriendItemStatus.INITIAL;
          break;
      }
    }

    return FriendItemState(status: status);
  }

}