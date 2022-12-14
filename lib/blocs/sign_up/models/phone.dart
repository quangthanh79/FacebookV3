
import 'package:formz/formz.dart';
enum PhoneValidationError{empty, wrongFormat}
class Phone extends FormzInput<String, PhoneValidationError>{

  const Phone.pure() : super.pure('');

  Phone.dirty(String value) : super.dirty(value);

  @override
  PhoneValidationError? validator(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regex = new RegExp(pattern);
    if(value.isEmpty){
      return PhoneValidationError.empty;
    }
    if(!regex.hasMatch(value)){
      return PhoneValidationError.wrongFormat;
    }
    return null;
  }

}