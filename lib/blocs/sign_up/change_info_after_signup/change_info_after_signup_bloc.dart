

import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/authen_repository.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'change_info_after_signup_event.dart';
part 'change_info_after_signup_state.dart';


class ChangeInfoAfterSignupBloc extends Bloc<ChangeInfoAfterSignupEvent, ChangeInfoAfterSignupState>{
  User user;
  AuthenRepository authenRepository = getIt<AuthenRepository>();
  ChangeInfoAfterSignupBloc({
    required this.user
  }) : super(ChangeInfoAfterSignupState(status: ChangeInfoAfterSignupStatus.INITIAL)){
    on<ReloadState>(reloadState);
    on<ChangeUsername>(changeUsername);
    on<ChangeAvatar>(changeAvatar);
    on<RemoveAvatar>(removeAvatar);
    on<Submit>(submit);
    on<Done>(done);
  }

  String? checkUsername(){
    print("check here");
    String username = user.username!;
    if (username.length <= 3) return "Username is too short";
    if (username.length >= 30) return "Username is too long";
    final regex = RegExp(r'^([a-zA-Z0-9ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\s]+)*$');
    if (!regex.hasMatch(username)) return "Username doesn't contain special character";
    return null;
  }

  Future<void> reloadState(ReloadState e, Emitter<ChangeInfoAfterSignupState> emit) async {
    if (user.username == "") {
      emit(ChangeInfoAfterSignupState(status: ChangeInfoAfterSignupStatus.INITIAL));
      return;
    }
    String? check_username = checkUsername();
    if (check_username == null){
      emit(ChangeInfoAfterSignupState(status: ChangeInfoAfterSignupStatus.OKAY));
      return;
    } else {
      emit(ChangeInfoAfterSignupState(
          status: ChangeInfoAfterSignupStatus.WRONG_USERNAME, message: check_username));
      return;
    }
  }

  Future<void> changeUsername(ChangeUsername e, Emitter<ChangeInfoAfterSignupState> emit) async {
    add(ReloadState());
  }

  Future<void> changeAvatar(ChangeAvatar e, Emitter<ChangeInfoAfterSignupState> emit) async {
    add(ReloadState());
  }

  Future<void> removeAvatar(RemoveAvatar e, Emitter<ChangeInfoAfterSignupState> emit) async {
    add(ReloadState());
  }

  Future<void> submit(Submit e, Emitter<ChangeInfoAfterSignupState> emit) async {
    emit(ChangeInfoAfterSignupState(status: ChangeInfoAfterSignupStatus.SENDING));
    ResponseUser? responseUser = await authenRepository.changeInfoAfterSignup(user.username!, user.avatar_file);
    if (responseUser == null){
      emit(ChangeInfoAfterSignupState(
          status: ChangeInfoAfterSignupStatus.FAILED, message: "Kết nối thất bại"));
      if (e.context != null){
        ScaffoldMessenger.of(e.context!).showSnackBar(const SnackBar(
          content: Text("Kết nối thất bại"),
        ));
      }
      return;
    }
    if (responseUser.code != "1000"){
      emit(ChangeInfoAfterSignupState(
          status: ChangeInfoAfterSignupStatus.FAILED, message: responseUser.message!));
      if (e.context != null){
        ScaffoldMessenger.of(e.context!).showSnackBar(SnackBar(
          content: Text(responseUser.message!),
        ));
      }
      return;
    }
    emit(ChangeInfoAfterSignupState(status: ChangeInfoAfterSignupStatus.SUCCESS));
    SessionUser.user = User(
      id: SessionUser.idUser,
      username: user.username
    );
    SessionUser.user?.avatar_file = user.avatar_file;
    ScaffoldMessenger.of(e.context!).showSnackBar(const SnackBar(
      content: Text("Đặt thông tin người dùng thành công"),
    ));
  }

  Future<void> done(Done e, Emitter<ChangeInfoAfterSignupState> emit) async {

  }

}
