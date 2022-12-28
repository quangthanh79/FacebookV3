// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:facebook_auth/domain/repositories/post_repository.dart';

import '../../core/common/error/failure.dart';
import '../../core/common/usecase.dart';

class DeletePostUseCase implements UseCase<dynamic, DeletePostParams> {
  final PostRepository repository;
  DeletePostUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, dynamic>> call(DeletePostParams params) {
    return repository.deletePost(token: params.token, postId: params.postId);
  }
}

class DeletePostParams {
  final String token;
  final String postId;
  const DeletePostParams({required this.token, required this.postId});
}
