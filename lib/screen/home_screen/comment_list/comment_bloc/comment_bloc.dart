// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook_auth/core/helper/current_user.dart';

import 'package:facebook_auth/data/models/comment_response.dart';
import 'package:facebook_auth/domain/use_cases/load_comment_use_case.dart';
import 'package:facebook_auth/domain/use_cases/set_comment_use_case.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/cupertino.dart';

import '../../../../utils/constant.dart' as constant;
import '../../model/comment.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final LoadCommentUseCase useCase;
  final SetCommentUseCase setCommentUseCase;
  CommentBloc(
    this.useCase,
    this.setCommentUseCase,
  ) : super(const CommentState(status: CommentStatus.initial)) {
    on<LoadCommentEvent>(_onLoadComment);
    on<AddComment>(_onAddComment);
  }

  _onLoadComment(LoadCommentEvent event, Emitter emit) async {
    emit(state.copyWith(status: CommentStatus.loading));
    var result = await useCase.call(LoadCommentsParams(
        token: SessionUser.token!,
        postId: event.postId,
        count: constant.count,
        index: 0));
    result.fold((l) {
      emit(state.copyWith(
          status: CommentStatus.loadedFailure, error: l.message));
    }, (r) {
      emit(state.copyWith(
          status: CommentStatus.loadedSuccess,
          itemList: List.of(r.map((e) => e.toEntity()))));
    });
  }

  _onAddComment(AddComment event, Emitter emit) async {
    if (event.content == '') return;
    if (state.itemList.isEmpty) {
      var myAvatar = CurrentUser.avatar;
      var userName = CurrentUser.userName;
      emit(state.copyWith(
          status: CommentStatus.loadedSuccess,
          itemList: [
            Comment(
                avatarUrl: myAvatar,
                userName: userName,
                time: 'Just ago',
                content: event.content)
          ],
          newComment: Comment(
              avatarUrl: myAvatar,
              userName: userName,
              time: 'Just ago',
              content: event.content)));
    }
    var result = await setCommentUseCase.call(SetCommentsParams(
        token: SessionUser.token!,
        postId: event.postId,
        comment: event.content,
        count: 20,
        index: 0));
    result.fold((l) {
      debugPrint(l.message);
      return;
    }, (r) {
      // var newList = state.itemList;
      // newList.insert(
      //     0,
      //     Comment(
      //         avatarUrl: avatarUrl,
      //         userName: userName,
      //         time: 'Just ago',
      //         content: event.content));
      emit(state.copyWith(
          status: CommentStatus.loadedSuccess,
          newComment: Comment(
              avatarUrl: CurrentUser.avatar,
              userName: CurrentUser.userName,
              time: 'Just ago',
              content: event.content)));
    });
  }
}
