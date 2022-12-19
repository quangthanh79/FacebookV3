import 'package:dartz/dartz.dart';
import 'package:facebook_auth/core/common/error/failure.dart';
import 'package:facebook_auth/core/common/usecase.dart';
import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/domain/repositories/post_repository.dart';

class GetUserInfoUseCase implements UseCase<Author, String> {
  final PostRepository repository;
  GetUserInfoUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Author>> call(String token) {
    return repository.getUserInfo(token);
  }
}
