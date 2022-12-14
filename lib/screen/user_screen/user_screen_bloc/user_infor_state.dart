
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:formz/formz.dart';


class UserInforState extends Equatable{
  final FormzStatus statusLoadInfo;
  final User? user;
  final ListFriend? listFriend;
  UserInforState({
    this.statusLoadInfo = FormzStatus.pure,
    this.user,
    this.listFriend
  });
  UserInforState copyWith(
      { FormzStatus? statusLoadInfo,
        User? user,
        ListFriend? listFriend
      })
  {
    return UserInforState(
      statusLoadInfo: statusLoadInfo ?? this.statusLoadInfo,
      user: user ?? this.user,
      listFriend: listFriend ?? this.listFriend
    );
  }
  @override
  List<Object?> get props => [this.statusLoadInfo,this.user,this.listFriend];
}
//
// class LoadingUserState extends UserInforState{}
// class NullUserState extends UserInforState{}
// class NotNullUserState extends UserInforState{}
