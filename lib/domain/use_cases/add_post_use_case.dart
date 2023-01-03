// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:facebook_auth/domain/repositories/post_repository.dart';

import '../../core/common/error/failure.dart';
import '../../core/common/usecase.dart';

class AddPostUseCase implements UseCase<String, AddPostParams> {
  final PostRepository repository;
  AddPostUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(AddPostParams params) {
    return repository.addPost(
        token: params.token,
        described: params.described,
        image: params.image,
        video: params.video);
  }
}

class AddPostParams {
  final String token;
  final String described;
  final List<File>? image;
  final File? video;
  const AddPostParams({
    required this.token,
    required this.described,
    this.image,
    this.video,
  });
}
