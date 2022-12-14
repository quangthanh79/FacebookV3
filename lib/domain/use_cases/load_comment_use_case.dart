// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:facebook_auth/core/common/error/failure.dart';
import 'package:facebook_auth/core/common/usecase.dart';
import 'package:facebook_auth/data/models/comment_response.dart';
import 'package:facebook_auth/domain/repositories/comment_repository.dart';

class LoadCommentUseCase
    implements UseCase<List<CommentModel>, LoadCommentsParams> {
  final CommentRepository commentRepository;
  LoadCommentUseCase({
    required this.commentRepository,
  });

  @override
  Future<Either<Failure, List<CommentModel>>> call(LoadCommentsParams params) {
    return commentRepository.loadListComments(
        token: params.token,
        postId: params.postId,
        index: params.index,
        count: params.count);
  }
}

class LoadCommentsParams extends Equatable {
  final String token;
  final String postId;
  final int count;
  final int index;
  const LoadCommentsParams({
    required this.token,
    required this.postId,
    required this.count,
    required this.index,
  });

  @override
  List<Object> get props => [token, count, index, postId];
}
