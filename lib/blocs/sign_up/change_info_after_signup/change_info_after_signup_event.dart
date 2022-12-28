

part of 'change_info_after_signup_bloc.dart';

class ChangeInfoAfterSignupEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class ReloadState extends ChangeInfoAfterSignupEvent{}
class ChangeUsername extends ChangeInfoAfterSignupEvent{}
class ChangeAvatar extends ChangeInfoAfterSignupEvent{}
class RemoveAvatar extends ChangeInfoAfterSignupEvent{}
// ignore: must_be_immutable
class Submit extends ChangeInfoAfterSignupEvent{
  BuildContext? context;
  Submit({this.context});
}
class Done extends ChangeInfoAfterSignupEvent{}

