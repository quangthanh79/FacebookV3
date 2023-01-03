
import 'package:equatable/equatable.dart';

enum ChangePasswordStatus{
  INIT,IN_PROGRESS, COMMON_MORE_80, INCORRECT, CORRECT, COMMON
}

class ChangePasswordState extends Equatable{

  ChangePasswordState({this.changePasswordStatus = ChangePasswordStatus.INIT});

  ChangePasswordStatus changePasswordStatus;

  ChangePasswordState copywith(ChangePasswordStatus? changePasswordStatus){
    return ChangePasswordState(changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus);
  }

  @override
  List<Object?> get props => [changePasswordStatus];

}