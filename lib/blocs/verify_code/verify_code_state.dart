
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class VerifyCodeState extends Equatable{
  final FormzStatus statusGetCode;
  final FormzStatus statusCheckCode;
  final FormzStatus statusDialog;
  final String verifyCode;
  // statusSlide for wait_sign_in_screen
  final FormzStatus statusSlide;


  const VerifyCodeState({
    this.statusGetCode = FormzStatus.pure,
    this.statusCheckCode = FormzStatus.pure,
    this.statusDialog   = FormzStatus.pure,
    this.statusSlide    = FormzStatus.pure,
    this.verifyCode  = ""
  });

  VerifyCodeState copyWidth({
    FormzStatus? statusGetCode,
    FormzStatus? statusCheckCode,
    FormzStatus? statusDialog,
    FormzStatus? statusSlide,
    String? verifyCode
  }){
    return VerifyCodeState(
        statusGetCode: statusGetCode ??  FormzStatus.pure,
        statusCheckCode: statusCheckCode ?? FormzStatus.pure,
        statusDialog: statusDialog ?? FormzStatus.pure,
        statusSlide: statusSlide ?? this.statusSlide,
        verifyCode: verifyCode ?? this.verifyCode
    );
  }
  @override
  List<Object?> get props => [this.statusGetCode,this.statusCheckCode,this.statusSlide,this.statusDialog,this.verifyCode];

}