// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:facebook_auth/core/common/error/failure.dart';
import 'package:facebook_auth/core/helper/cache_helper.dart';
import 'package:facebook_auth/data/datasource/remote/post_datasource.dart';
import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/domain/repositories/post_repository.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/injection.dart';

import '../../core/common/error/exceptions.dart';

enum PostType { home, profile, video, search }

class PostRepositoryImpl implements PostRepository {
  final PostDataSource dataSource;
  PostRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, PostListResponse>> loadListPosts(
      {required String token,
      String? keyword,
      String? targetId,
      required int index,
      required int count,
      required PostType type}) async {
    try {
      switch (type) {
        case PostType.home:
          CacheHelper cacheHelper = getIt();
          var response = await dataSource.loadListPosts(
              token: token, count: count, index: index);
          cacheHelper.setListPost(response);
          return Right(response);
        case PostType.profile:
          var response = await dataSource.loadListPostsInProfile(
              token: token,
              count: count,
              index: index,
              targetId: targetId ?? '');
          return Right(response);
        case PostType.video:
          var response = await dataSource.loadListVideos(
              token: token, count: count, index: index);
          return Right(response);
        case PostType.search:
          var response = await dataSource.searchPost(
              keyword: keyword ?? '', token: token, count: count, index: index);
          return Right(response);
      }
      //return const Left(ServerFailure(unexpectedError));
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
