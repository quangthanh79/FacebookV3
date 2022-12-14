// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facebook_auth/core/common/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:facebook_auth/data/models/comment_response.dart';

import '../../core/common/error/exceptions.dart';
import '../../domain/repositories/comment_repository.dart';
import '../datasource/remote/comment_datasource.dart';
import 'post_repository_impl.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentDataSource dataSource;
  CommentRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<CommentModel>>> loadListComments(
      {required String token,
      required String postId,
      required int index,
      required int count}) async {
    try {
      return Right(await dataSource.loadListComments(
          token: token, postId: postId, count: count, index: index));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> setComment(
      {required String token,
      required String postId,
      required String comment,
      required int index,
      required int count}) async {
    try {
      return Right(await dataSource.setComment(
          token: token,
          postId: postId,
          comment: comment,
          count: count,
          index: index));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
