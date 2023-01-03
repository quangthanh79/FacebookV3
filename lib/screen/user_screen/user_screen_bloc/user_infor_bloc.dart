
import 'dart:math';

import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../data/models/user_info.dart';
import 'package:equatable/equatable.dart';

part 'user_infor_event.dart';
part 'user_infor_state.dart';

class UserInforBloc extends Bloc<UserInforEvent, UserInforState> {
  UserRepository userRepository;
  // FriendRepository friendRepository;
  late User user;
  // late ListFriend listFriend;

  UserInforBloc({
    required this.userRepository,
    // required this.friendRepository,
    required this.user,
    // required this.list stFriend
  }) : super(const UserInforState(status: UserInforStatus.LOADING)) {
    on<LoadUserEvent>(loadUser);
    on<ReloadUserEvent>(reloadUser);
    on<BackgroundLoadUserEvent>(loadUserBackground);
  }

  Future<void> loadUser(UserInforEvent event, Emitter<UserInforState> emit) async{
    emit(const UserInforState(status: UserInforStatus.LOADING));
    
    ResponseUser? responseUser;
    // ResponseListFriend? responseListFriend;
    // await Future.wait([
    //   Future(() async => responseUser = await userRepository.getUserInfor(user.id ?? "")),
    //   Future(() async => responseListFriend = await friendRepository.getUserFriends(user.id!, 1))
    // ]);

    responseUser = await userRepository.getUserInfor(user.id ?? "");
    // responseListFriend = await friendRepository.getUserFriends(user.id!, 1);
    
    // ResponseListFriend? responseListFriend = await userRepository.getUserFriends(user.id ?? "",1);

    if (responseUser == null){
      // print("FAILURE: "+ response_list_friend.toString());
      emit(const UserInforState(status: UserInforStatus.FAIL));
      return;
    }
    if (responseUser.code == "9995"){
      responseUser.data.copyFrom(user);
      responseUser.data.is_friend = responseUser.details;
    }
    // if (responseListFriend != null) {
    //   listFriend.copyFrom(responseListFriend!.data!);
    // }
    user.copyFrom(responseUser.data);
    emit(getState());
  }

  Future<void> reloadUser(UserInforEvent event, Emitter<UserInforState> emit) async{
    emit(getState());
  }

  Future<void> loadUserBackground(UserInforEvent event, Emitter<UserInforState> emit) async{
    ResponseUser? responseUser = await userRepository.getUserInfor(user.id ?? "");
    if (responseUser == null){
      return;
    }
    if (responseUser.code == "9995"){
      responseUser.data.copyFrom(user);
      responseUser.data.is_friend = responseUser.details;
    }
    user.copyFrom(responseUser.data);
    emit(getState());
  }

  UserInforState getState(){
    switch (user.is_friend){
      case "BLOCKING":
        return const UserInforState(status: UserInforStatus.BLOCKING);
      case "BLOCKED":
        return const UserInforState(status: UserInforStatus.BLOCKED);
      default:
        return const UserInforState(status: UserInforStatus.LOADED);
    }
  }

}