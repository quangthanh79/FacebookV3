// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook_auth/core/helper/cache_helper.dart';

import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/data/repository/post_repository_impl.dart';
import 'package:facebook_auth/domain/use_cases/get_user_info_use_case.dart';
import 'package:facebook_auth/domain/use_cases/load_list_posts_use_case.dart';
import 'package:facebook_auth/screen/home_screen/model/post.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/cupertino.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadListPostUseCase useCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  HomeBloc(
    this.useCase,
    this.getUserInfoUseCase,
  ) : super(const HomeState()) {
    on<LoadListPost>(_onLoadListPost);
    on<ResetListPost>(_onResetListPost);
    on<MakeTypePost>(_onMakeTypePost);
    on<DisposePost>(_onDisposePost);
  }

  _onLoadListPost(LoadListPost event, Emitter emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    // if (connectivityResult == ConnectivityResult.none &&
    //     state.isNoInternetFirstLoad) {
    //   var fromCache = getIt<CacheHelper>().getListPost;
    //   if (fromCache != '') {
    //     emit(state.copyWith(
    //         status: HomeStatus.loadedSuccess,
    //         isNoInternetFirstLoad: false,
    //         itemList: List.of(PostListResponse.fromJson(json.decode(fromCache))
    //             .posts!
    //             .map((e) => e.toEntity()))));
    //   } else {
    //     emit(state.copyWith(isNoInternetFirstLoad: false));
    //   }
    // }
    var result = await useCase.call(LoadListPostsParams(
        type: state.type,
        keyword: event.keyword,
        targetId: event.targetId,
        token: SessionUser.token!,
        count: count,
        index: state.pageIndex * count));
    result.fold((l) {
      emit(state.copyWith(status: HomeStatus.loadedFailure, error: l.message));
    }, (r) {
      emit(state.copyWith(
          pageIndex: state.pageIndex + 1,
          status: HomeStatus.loadedSuccess,
          itemList: r.posts != null
              ? List.of(r.posts!.map((e) => e.toEntity()))
              : []));
    });
  }

  _onResetListPost(ResetListPost event, Emitter emit) async {
    emit(state.copyWith(
      itemList: [],
      pageIndex: 0,
    ));
  }

  _onMakeTypePost(MakeTypePost event, Emitter emit) {
    emit(state.copyWith(type: event.type));
  }

  _onDisposePost(DisposePost event, Emitter emit) {
    emit(state.copyWith(itemList: [], pageIndex: 0, context: event.context));
  }
}
