
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:formz/formz.dart';


class UserInforState extends Equatable{
  final FormzStatus statusLoadInfo;
  UserInforState({
    this.statusLoadInfo = FormzStatus.pure
  });
  UserInforState copyWith(
      { FormzStatus? statusLoadInfo,
      })
  {
    return UserInforState(
      statusLoadInfo: statusLoadInfo ?? this.statusLoadInfo,
    );
  }
  @override
  List<Object?> get props => [this.statusLoadInfo, Random().nextInt(10000)];
}
//
// class LoadingUserState extends UserInforState{}
// class NullUserState extends UserInforState{}
// class NotNullUserState extends UserInforState{}
