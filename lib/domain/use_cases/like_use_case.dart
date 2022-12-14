// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:facebook_auth/domain/repositories/like_repository.dart';

import '../../core/common/error/failure.dart';
import '../../core/common/usecase.dart';

class LikeUseCase implements UseCase<bool, LikeParams> {
  final LikeRepository repository;
  LikeUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(LikeParams params) {
    return repository.like(token: params.token, postId: params.postId);
  }
}

class LikeParams {
  final String token;
  final String postId;
  const LikeParams({required this.token, required this.postId});
}
