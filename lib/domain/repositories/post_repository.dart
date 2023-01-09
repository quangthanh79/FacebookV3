import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/data/repository/post_repository_impl.dart';

import '../../core/common/error/failure.dart';

abstract class PostRepository {
  Future<Either<Failure, PostListResponse>> loadListPosts(
      {String? keyword,
      String? targetId,
      required String token,
      required int index,
      required int count,
      required PostType type});
  Future<Either<Failure, AddPostResponse>> addPost(
      {required String token,
      required String described,
      List<File>? image,
      File? video});
  Future<Either<Failure, AddPostResponse>> editPost(
      {required String token,
      required String id,
      required String described,
      List<File>? image,
      File? video});
  Future<Either<Failure, Author>> getUserInfo(String token);
  Future<Either<Failure, dynamic>> deletePost(
      {required String token, required String postId});
}
