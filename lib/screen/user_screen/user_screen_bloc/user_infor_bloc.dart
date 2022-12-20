
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
    // required this.listFriend
  }) : super(UserInforState()) {
    on<LoadUserEvent>(loadUser);
    on<ReloadUserEvent>(reloadUser);
    on<BackgroundLoadUserEvent>(loadUserBackground);
  }

  Future<void> loadUser(UserInforEvent event, Emitter<UserInforState> emit) async{
    emit(state.copyWith(statusLoadInfo: FormzStatus.submissionInProgress));
    
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
      emit(state.copyWith(statusLoadInfo: FormzStatus.submissionFailure));
      return;
    }
    // if (responseListFriend != null) {
    //   listFriend.copyFrom(responseListFriend!.data!);
    // }
    user.copyFrom(responseUser.data!);
    emit(state.copyWith(statusLoadInfo: FormzStatus.submissionSuccess));

  }

  Future<void> reloadUser(UserInforEvent event, Emitter<UserInforState> emit) async{
    emit(state.copyWith(statusLoadInfo: FormzStatus.submissionSuccess));
  }

  Future<void> loadUserBackground(UserInforEvent event, Emitter<UserInforState> emit) async{
    ResponseUser? responseUser = await userRepository.getUserInfor(user.id ?? "");
    if (responseUser == null || responseUser.code != "1000"){
      return;
    }
    user.copyFrom(responseUser.data!);
    emit(state.copyWith(statusLoadInfo: FormzStatus.submissionSuccess));
  }

}