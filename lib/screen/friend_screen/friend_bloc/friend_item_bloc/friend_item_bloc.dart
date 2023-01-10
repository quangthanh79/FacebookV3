

import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'friend_item_state.dart';
part 'friend_item_event.dart';

class FriendItemBloc extends Bloc<FriendItemEvent, FriendItemState>{
  Friend friend;
  UserRepository userRepository = getIt<UserRepository>();
  FriendRepository friendRepository;
  FriendItemBloc({required this.friend, required this.friendRepository})
  :super(FriendItemState(status: FriendItemStatus.LOADING)){
    on<SendRequestEvent>(sendRequestFriend);
    on<CancelRequestEvent>(cancelRequestFriend);
    on<AcceptRequestEvent>(acceptRequestFriend);
    on<CancelFriendEvent>(cancelFriend);
    on<InitButtonsEvent>(initButtons);
    on<UpdateButtonsEvent>(updateButtons);
  }

  Future<void> sendRequestFriend(SendRequestEvent e, Emitter<FriendItemState> emit) async{
    if (friend.is_friend == null || friend.is_friend != "NOT_FRIEND") return;
    emit(FriendItemState(status: FriendItemStatus.REQUESTING));
    ResponseListFriend? responseListFriend = await friendRepository.setRequestFriend(friend.user_id!);
    if (responseListFriend != null && responseListFriend.code == "1000"){
      friend.is_friend = "REQUESTED";
    } else {
      emit(FriendItemState(status: FriendItemStatus.NOT_FRIEND));
    }
  }
  Future<void> cancelRequestFriend(CancelRequestEvent e, Emitter<FriendItemState> emit) async{
    if (friend.is_friend == null || friend.is_friend != "REQUESTED") return;
    friend.is_friend = "NOT_FRIEND";
    emit(FriendItemState(status: FriendItemStatus.NOT_FRIEND));
    ResponseListFriend? responseListFriend = await friendRepository.setRequestFriend(friend.user_id!);
    if (responseListFriend != null && responseListFriend.code == "1000") {
      friend.is_friend = "NOT_FRIEND";
    } else {
      emit(FriendItemState(status: FriendItemStatus.REQUESTING));
    }
  }
  Future<void> acceptRequestFriend(AcceptRequestEvent e, Emitter<FriendItemState> emit) async{
    if (friend.is_friend == null || friend.is_friend != "REQUESTING") return;
    if (e.code == Acceptable.ACCEPT){
      emit(FriendItemState(status: FriendItemStatus.IS_FRIEND));
    } else {
      emit(FriendItemState(status: FriendItemStatus.NOT_FRIEND));
    }
    ResponseListFriend? responseListFriend = await friendRepository.setAcceptFriend(friend.user_id!, e.code == Acceptable.ACCEPT);
    if (responseListFriend != null && responseListFriend.code == "1000") {
      if (e.code == Acceptable.ACCEPT) {
        friend.is_friend = "IS_FRIEND";
      } else {
        friend.is_friend = "NOT_FRIEND";
      }
    } else {
      emit(FriendItemState(status: FriendItemStatus.REQUESTED));
    }
  }
  Future<void> cancelFriend(CancelFriendEvent e, Emitter<FriendItemState> emit) async{
    if (friend.is_friend == null || friend.is_friend != "IS_FRIEND") return;
    emit(FriendItemState(status: FriendItemStatus.NOT_FRIEND));
    ResponseActionFriend? responseActionFriend = await friendRepository.setCancelFriend(friend.user_id!);
    if (responseActionFriend != null && responseActionFriend.code == "1000") {
      friend.is_friend = "NOT_FRIEND";
    } else {
      emit(FriendItemState(status: FriendItemStatus.IS_FRIEND));
    }
  }
  Future<void> initButtons(InitButtonsEvent e, Emitter<FriendItemState> emit) async{
    emit(getState());
  }
  Future<void> updateButtons(UpdateButtonsEvent e, Emitter<FriendItemState> emit) async{
    if (friend.is_friend == "ME") return;
    emit(FriendItemState(status: FriendItemStatus.LOADING));
    ResponseUser? responseUser = await userRepository.getUserInfor(friend.user_id!);

    if (responseUser == null){
      emit(FriendItemState(status: FriendItemStatus.LOADING));
      return;
    }

    if (responseUser.code == "9995"){
      friend.is_friend = responseUser.details;
      // print("blockkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
    } else {
      friend.is_friend = responseUser.data.is_friend;
    }

    emit(getState());
  }

  FriendItemState getState(){
    FriendItemStatus status = FriendItemStatus.LOADING;
    switch (friend.is_friend) {
      case "ME":
        status = FriendItemStatus.ME;
        break;
      case "NOT_FRIEND":
        status = FriendItemStatus.NOT_FRIEND;
        break;
      case "IS_FRIEND":
        status = FriendItemStatus.IS_FRIEND;
        break;
      case "REQUESTED":
        status = FriendItemStatus.REQUESTED;
        break;
      case "REQUESTING":
        status = FriendItemStatus.REQUESTING;
        break;
      case "BLOCKING":case "BLOCKED":

      status = FriendItemStatus.BLOCK;
      break;
      case null:
        status = FriendItemStatus.LOADING;
        break;
    }

    return FriendItemState(status: status);
  }

}