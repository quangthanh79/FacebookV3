// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:facebook_auth/core/common/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:facebook_auth/data/datasource/remote/post_datasource.dart';
import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/domain/repositories/post_repository.dart';

import '../../core/common/error/exceptions.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource dataSource;
  PostRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, PostListResponse>> loadListPosts(
      {required String token, required int index, required int count}) async {
    try {
      return Right(await dataSource.loadListPosts(
          token: token, count: count, index: index));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> addPost(
      {required String token, required String described, File? image}) async {
    try {
      return Right(await dataSource.addPost(
          token: token, described: described, image: image));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
