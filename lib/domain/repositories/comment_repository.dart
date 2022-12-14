import 'package:dartz/dartz.dart';
import 'package:facebook_auth/data/models/comment_response.dart';

import '../../core/common/error/failure.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<CommentModel>>> loadListComments(
      {required String token,
      required String postId,
      required int index,
      required int count});
  Future<Either<Failure, List<CommentModel>>> setComment(
      {required String token,
      required String postId,
      required String comment,
      required int index,
      required int count});
}
