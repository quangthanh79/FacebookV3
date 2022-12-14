// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:facebook_auth/domain/use_cases/like_use_case.dart';
import 'package:facebook_auth/utils/session_user.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeUseCase useCase;
  LikeBloc(
    this.useCase,
  ) : super(LikeInitial()) {
    on<AddLikeEvent>(_onAddLikeEvent);
  }

  _onAddLikeEvent(AddLikeEvent event, Emitter emit) {
    useCase.call(LikeParams(token: SessionUser.token!, postId: event.postId));
  }
}
