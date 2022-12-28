// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook_auth/core/helper/current_user.dart';
import 'package:facebook_auth/data/repository/post_repository_impl.dart';

import 'package:facebook_auth/domain/use_cases/add_post_use_case.dart';
import 'package:facebook_auth/screen/home_screen/home_body.dart';
import 'package:facebook_auth/screen/home_screen/model/post.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final AddPostUseCase useCase;
  AddPostBloc(
    this.useCase,
  ) : super(const AddPostState()) {
    on<AddPost>(_onAddPost);
    on<PostContentChange>(_onPostContentChange);
    on<PickImage>(_onPickImage);
    on<PickVideo>(_onPickVideo);
    on<EditPostEvent>(_onEditPostEvent);
  }

  _onAddPost(AddPost event, Emitter emit) async {
    emit(state.copyWith(status: AddPostStatus.posting));
    var result = await useCase.call(AddPostParams(
        token: SessionUser.token!,
        described: state.content,
        video: state.addPostType == AddPostType.video ? state.video : null,
        image: state.addPostType == AddPostType.image
            ? (state.images != null ? state.images! : null)
            : null));
    result.fold((l) {
      emit(state.copyWith(status: AddPostStatus.failure, error: l.message));
    }, (r) {
      event.context.read<ListPostNotify>().addPost(
          Post(
              postId: r,
              userName: CurrentUser.userName ?? 'Facebook user',
              avatarUrl: CurrentUser.avatar,
              content: state.content,
              user_id: CurrentUser.id,
              time: 'Just ago',
              likesNumber: 0,
              commentsNumber: 0,
              isSelfLiking: false),
          PostType.home);
      emit(state.copyWith(status: AddPostStatus.success));
    });
  }

  _onPostContentChange(PostContentChange event, Emitter emit) {
    emit(state.copyWith(content: event.content));
  }

  _onPickImage(PickImage event, Emitter emit) {
    emit(state.copyWith(images: event.images, addPostType: AddPostType.image));
  }

  _onPickVideo(PickVideo event, Emitter emit) {
    emit(state.copyWith(video: event.video, addPostType: AddPostType.video));
  }

  _onEditPostEvent(EditPostEvent event, Emitter emit) {
    emit(state.copyWith(
        video: event.video,
        addPostType: event.addPostType,
        images: event.images,
        content: event.content));
  }
}
