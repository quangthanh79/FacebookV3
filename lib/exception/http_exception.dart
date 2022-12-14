import 'dart:io';

class HttpException implements Exception{
  final prefix;
  final message;

  HttpException(this.prefix, this.message);

  @override
  String toString() {
    return "$prefix$message";
  }
}