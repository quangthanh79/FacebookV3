// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:facebook_auth/core/networking/api_service.dart';
import 'package:facebook_auth/data/models/comment_response.dart';
import 'package:facebook_auth/utils/constant.dart';

import '../../../core/common/error/exceptions.dart';

abstract class CommentDataSource {
  Future<List<CommentModel>> loadListComments(
      {required String token,
      required String postId,
      required int count,
      required int index});

  Future<List<CommentModel>> setComment(
      {required String token,
      required String postId,
      required String comment,
      required int count,
      required int index});
}

class CommentDataSourceImpl implements CommentDataSource {
  final ApiService apiService;
  CommentDataSourceImpl({
    required this.apiService,
  });
  @override
  Future<List<CommentModel>> loadListComments(
      {required String token,
      required String postId,
      required int count,
      required int index}) async {
    try {
      var response = await apiService.getComment(
          token: token, postId: postId, count: count, index: index);
      if (response.statusCode == '1000') {
        if (response.data == null) {
          throw ServerException('Comment data is null');
        }
        return response.data!.reversed.toList();
      }
      throw ServerException(response.messages ?? unexpectedError);
    } on DioError catch (e) {
      throw ServerException.handleError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CommentModel>> setComment(
      {required String token,
      required String postId,
      required String comment,
      required int count,
      required int index}) async {
    try {
      var response = await apiService.setComment(
          token: token,
          postId: postId,
          comment: comment,
          count: count,
          index: index);
      if (response.statusCode == '1000') {
        if (response.data == null) {
          throw ServerException('Comment data is null');
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
