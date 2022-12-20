
part of 'user_infor_bloc.dart';

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
