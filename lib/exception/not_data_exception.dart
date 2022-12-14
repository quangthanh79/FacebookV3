

import 'http_exception.dart';

class NotDataException extends HttpException{
  NotDataException(message) : super( "Error During Communication: ", message);

}