

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class SignOutState extends Equatable{

  final FormzStatus statusSignOut;

  SignOutState copyWith({FormzStatus? status}){
    return SignOutState(statusSignOut: status ?? this.statusSignOut);
  }

  const SignOutState({this.statusSignOut = FormzStatus.pure});

  @override
  List<Object?> get props => [this.statusSignOut];

}