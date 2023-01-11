
part of 'user_infor_bloc.dart';

enum UserInforStatus{
  LOADING, LOADED, FAIL, BLOCKING, BLOCKED
}

class UserInforState{
  final UserInforStatus status;
  UserInforState({
    required this.status
  });

  // @override
  // List<Object?> get props => [status, Random().nextInt(10000)];
}
//
// class LoadingUserState extends UserInforState{}
// class NullUserState extends UserInforState{}
// class NotNullUserState extends UserInforState{}
