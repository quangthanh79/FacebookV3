

import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_event.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_bloc/user_infor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../data/models/user_info.dart';

class UserInforBloc extends Bloc<UserInforEvent, UserInforState> {
  UserRepository userRepository;
  FriendRepository friendRepository;
  User user;


  UserInforBloc({
    required this.userRepository,
    required this.friendRepository,
    required this.user,
  }) : super(UserInforState()) {
    on<UserInforEvent>(loadUser);
    on<ReloadUserEvent>(reloadUser);
    on<BackgroundLoadUserEvent>(loadUserBackground);
  }

  Future<void> loadUser(UserInforEvent event, Emitter<UserInforState> emit) async{
    emit(state.copyWith(statusLoadInfo: FormzStatus.submissionInProgress));
    ResponseUser? response_user = await userRepository.getUserInfor(user.id ?? "");
    ResponseListFriend? response_list_friend = await userRepository.getUserFriends(user.id ?? "",1);

    if (response_user == null || response_list_friend == null){
      print("FAILURE: "+ response_list_friend.toString());
      emit(state.copyWith(
        statusLoadInfo: FormzStatus.submissionFailure
      ));
      return;
    }
    emit(state.copyWith(
        statusLoadInfo: FormzStatus.submissionSuccess,
        user: response_user.data,
        listFriend: response_list_friend.data
    ));
    // user.copyFrom(response_user.data!);
    // emit(NotNullUserState());
  }

  Future<void> reloadUser(UserInforEvent event, Emitter<UserInforState> emit) async{
    // emit(NotNullUserState());
  }

  Future<void> loadUserBackground(UserInforEvent event, Emitter<UserInforState> emit) async{
    ResponseUser? response_user = await userRepository.getUserInfor(user.id ?? "");
    if (response_user == null || response_user.code != "1000"){
      return;
    }
    user.copyFrom(response_user.data!);
    // emit(NotNullUserState());
  }

}