import 'http_exception.dart';

class FetchDataException extends HttpException{
  FetchDataException(message) : super( "Error During Communication: ", message);

}