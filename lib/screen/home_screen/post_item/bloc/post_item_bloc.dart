import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook_auth/screen/home_screen/model/post.dart';

part 'post_item_event.dart';
part 'post_item_state.dart';

class PostItemBloc extends Bloc<PostItemEvent, PostItemState> {
  PostItemBloc() : super(const PostItemState(status: PostItemStatus.initial)) {
    on<PostInitEvent>(_onPostInitEvent);
    on<LikeClickEvent>(_onLikeClickEvent);
  }

  _onLikeClickEvent(LikeClickEvent event, Emitter emit) {
    if (state.status == PostItemStatus.liked) {
      emit(state.copyWith(status: PostItemStatus.unLiked));
    } else {
      emit(state.copyWith(status: PostItemStatus.liked));
    }
  }

  _onPostInitEvent(PostInitEvent event, Emitter emit) {
    if (event.isSelfLiking) {
      emit(state.copyWith(status: PostItemStatus.liked));
    } else {
      emit(state.copyWith(status: PostItemStatus.unLiked));
    }
  }
}
