// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook_auth/core/common/error/failure.dart';

import 'package:facebook_auth/core/common/usecase.dart';
import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/domain/repositories/post_repository.dart';

class LoadListPostUseCase
    implements UseCase<PostListResponse, LoadListPostsParams> {
  final PostRepository postRepository;
  LoadListPostUseCase({
    required this.postRepository,
  });

  @override
  Future<Either<Failure, PostListResponse>> call(LoadListPostsParams params) {
    return postRepository.loadListPosts(
        token: params.token, index: params.index, count: params.count);
  }
}

class LoadListPostsParams extends Equatable {
  final String token;
  final int count;
  final int index;
  const LoadListPostsParams({
    required this.token,
    required this.count,
    required this.index,
  });

  @override
  List<Object> get props => [token, count, index];
}
