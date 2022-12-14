import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/common/error/failure.dart';

abstract class LikeRepository {
  Future<Either<Failure, bool>> like(
      {required String token, required String postId});
}
