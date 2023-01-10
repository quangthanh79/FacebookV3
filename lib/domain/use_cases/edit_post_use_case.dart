// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/domain/repositories/post_repository.dart';

import '../../core/common/error/failure.dart';
import '../../core/common/usecase.dart';

class EditPostUseCase implements UseCase<AddPostResponse, EditPostParams> {
  final PostRepository repository;
  EditPostUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, AddPostResponse>> call(EditPostParams params) {
    return repository.editPost(
        id: params.id,
        token: params.token,
        described: params.described,
        image: params.image,
        video: params.video);
  }
}

class EditPostParams {
  final String token;
  final String id;
  final String described;
  final List<File>? image;
  final File? video;
  const EditPostParams({
    required this.token,
    required this.id,
    required this.described,
    this.image,
    this.video,
  });
}
