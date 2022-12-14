import 'package:formz/formz.dart';
enum PasswordValidationError{empty, inValidLength}
class Password extends FormzInput<String, PasswordValidationError>{

  const Password.pure() : super.pure('');

  Password.dirty(String value) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {

    if(value.isEmpty){
      return PasswordValidationError.empty;
    }
    if(value.length <6 ){
      return PasswordValidationError.inValidLength;
    }
    return null;
  }

}