
import 'package:equatable/equatable.dart';

class ChangePasswordEvent extends Equatable{
  String curPass, newPass;

  ChangePasswordEvent({required this.curPass,required this.newPass});

  @override
  List<Object?> get props => [curPass, newPass];
}