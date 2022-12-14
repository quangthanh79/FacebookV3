// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:facebook_auth/data/models/comment_response.dart';
import 'package:facebook_auth/domain/use_cases/load_comment_use_case.dart';
import 'package:facebook_auth/domain/use_cases/set_comment_use_case.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/cupertino.dart';

import '../../../../utils/constant.dart';
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
    on<CommentContentChange>(_onCommentChange);
  }

  _onLoadComment(LoadCommentEvent event, Emitter emit) async {
    emit(state.copyWith(status: CommentStatus.loading));
    var result = await useCase.call(LoadCommentsParams(
        token: SessionUser.token!,
        postId: event.postId,
        count: count,
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
    if (state.addCommentContent == '') return;
    if (state.itemList.isEmpty) {
      emit(state.copyWith(
          status: CommentStatus.loadedSuccess,
          itemList: [
            Comment(
                avatarUrl: avatarUrl,
                userName: userName,
                time: 'Just ago',
                content: state.addCommentContent!)
          ],
          newComment: Comment(
              avatarUrl: avatarUrl,
              userName: userName,
              time: 'Just ago',
              content: state.addCommentContent!)));
    }
    var result = await setCommentUseCase.call(SetCommentsParams(
        token: postToken,
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
      //         content: state.addCommentContent!));
      emit(state.copyWith(
          status: CommentStatus.loadedSuccess,
          newComment: Comment(
              avatarUrl: avatarUrl,
              userName: userName,
              time: 'Just ago',
              content: state.addCommentContent!)));
    });
  }

  _onCommentChange(CommentContentChange event, Emitter emit) {
    emit(state.copyWith(addCommentContent: event.content));
  }
}
