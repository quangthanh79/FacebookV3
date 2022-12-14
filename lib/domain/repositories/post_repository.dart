import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:facebook_auth/data/models/post_response.dart';

import '../../core/common/error/failure.dart';

abstract class PostRepository {
  Future<Either<Failure, PostListResponse>> loadListPosts(
      {required String token, required int index, required int count});
  Future<Either<Failure, String>> addPost(
      {required String token, required String described, File? image});
}
