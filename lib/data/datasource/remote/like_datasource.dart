// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:facebook_auth/core/networking/api_service.dart';
import 'package:facebook_auth/utils/constant.dart';

import '../../../core/common/error/exceptions.dart';

abstract class LikeDataSource {
  Future<bool> like({
    required String token,
    required String postId,
  });
}

class LikeDataSourceImpl implements LikeDataSource {
  final ApiService apiService;
  LikeDataSourceImpl({
    required this.apiService,
  });
  @override
  Future<bool> like({
    required String token,
    required String postId,
  }) async {
    try {
      var response = await apiService.like(token: token, postId: postId);
      if (response.statusCode == '1000') {
        if (response.data == null) {
          throw ServerException('Error');
        }
        return response.data!;
      }
      throw ServerException(response.messages ?? unexpectedError);
    } on DioError catch (e) {
      throw ServerException.handleError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
