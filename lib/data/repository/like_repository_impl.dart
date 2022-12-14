// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:facebook_auth/core/common/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../core/common/error/exceptions.dart';
import '../../domain/repositories/like_repository.dart';
import '../datasource/remote/like_datasource.dart';
import 'post_repository_impl.dart';

class LikeRepositoryImpl implements LikeRepository {
  final LikeDataSource dataSource;
  LikeRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, bool>> like(
      {required String token, required String postId}) async {
    try {
      return Right(await dataSource.like(token: token, postId: postId));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
