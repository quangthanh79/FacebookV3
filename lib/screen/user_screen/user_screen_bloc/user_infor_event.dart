

part of 'user_infor_bloc.dart';

abstract class UserInforEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadUserEvent extends UserInforEvent{}
class BackgroundLoadUserEvent extends UserInforEvent{}
class ReloadUserEvent extends UserInforEvent{}