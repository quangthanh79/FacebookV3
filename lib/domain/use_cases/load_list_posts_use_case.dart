// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:facebook_auth/core/common/error/failure.dart';
import 'package:facebook_auth/core/common/usecase.dart';
import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/data/repository/post_repository_impl.dart';
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
        keyword: params.keyword,
        token: params.token,
        index: params.index,
        count: params.count,
        type: params.type);
  }
}

class LoadListPostsParams extends Equatable {
  final String token;
  final int count;
  final int index;
  final PostType type;
  final String? keyword;
  const LoadListPostsParams({
    required this.token,
    required this.count,
    required this.index,
    required this.type,
    this.keyword,
  });

  @override
  List<Object?> get props => [token, count, index, type, keyword];
}
