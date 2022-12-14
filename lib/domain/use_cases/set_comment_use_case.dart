// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:facebook_auth/core/common/error/failure.dart';
import 'package:facebook_auth/core/common/usecase.dart';
import 'package:facebook_auth/data/models/comment_response.dart';
import 'package:facebook_auth/domain/repositories/comment_repository.dart';

class SetCommentUseCase
    implements UseCase<List<CommentModel>, SetCommentsParams> {
  final CommentRepository commentRepository;
  SetCommentUseCase({
    required this.commentRepository,
  });

  @override
  Future<Either<Failure, List<CommentModel>>> call(SetCommentsParams params) {
    return commentRepository.setComment(
        token: params.token,
        postId: params.postId,
        comment: params.comment,
        index: params.index,
        count: params.count);
  }
}

class SetCommentsParams extends Equatable {
  final String token;
  final String postId;
  final String comment;
  final int count;
  final int index;
  const SetCommentsParams({
    required this.token,
    required this.postId,
    required this.comment,
    required this.count,
    required this.index,
  });

  @override
  List<Object> get props => [token, count, index, postId, comment];
}
