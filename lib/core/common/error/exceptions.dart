import 'dart:io';

import 'package:dio/dio.dart';

import '../../../utils/constant.dart';
import '../../networking/api_response.dart';
import '../../networking/server_message_response.dart';

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, {this.statusCode});

  static ServerException handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return ServerException(timeOut, statusCode: error.response?.statusCode);
      case DioErrorType.connectTimeout:
        return ServerException(timeOut, statusCode: error.response?.statusCode);
      case DioErrorType.receiveTimeout:
        return ServerException(timeOut, statusCode: error.response?.statusCode);
      case DioErrorType.sendTimeout:
        return ServerException(timeOut, statusCode: error.response?.statusCode);
      case DioErrorType.response:
        if (error.response?.data is Map<String, dynamic>) {
          var errorResponse = ApiResponse.fromJson(
              error.response?.data,
              (json) =>
                  ServerMessageResponse.fromJson(json as Map<String, dynamic>));
          return ServerException(errorResponse.data?.message ?? "",
              statusCode: int.parse(errorResponse.statusCode!));
        } else {
          return ServerException(unexpectedError,
              statusCode: error.response?.statusCode);
        }
      case DioErrorType.other:
        if (error.error is SocketException) {
          return ServerException(networkUnavailable,
              statusCode: error.response?.statusCode);
        } else {
          return ServerException(unexpectedError,
              statusCode: error.response?.statusCode);
        }
      default:
        return ServerException(unexpectedError,
            statusCode: error.response?.statusCode);
    }
  }
}
