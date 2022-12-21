// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:facebook_auth/core/common/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:facebook_auth/core/helper/cache_helper.dart';
import 'package:facebook_auth/data/datasource/remote/post_datasource.dart';
import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/domain/repositories/post_repository.dart';
import 'package:facebook_auth/utils/injection.dart';

import '../../core/common/error/exceptions.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource dataSource;
  PostRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, PostListResponse>> loadListPosts(
      {required String token, required int index, required int count}) async {
    CacheHelper cacheHelper = getIt();
    try {
      var response = await dataSource.loadListPosts(
          token: token, count: count, index: index);
      cacheHelper.setListPost(response);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> addPost(
      {required String token,
      required String described,
      List<File>? image,
      File? video}) async {
    try {
      return Right(await dataSource.addPost(
          token: token, described: described, image: image, video: video));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Author>> getUserInfo(String token) async {
    try {
      return Right(await dataSource.getUserInfo(token));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
