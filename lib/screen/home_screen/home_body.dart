// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:facebook_auth/core/helper/current_user.dart';
import 'package:facebook_auth/domain/use_cases/get_user_info_use_case.dart';
import 'package:facebook_auth/screen/home_screen/post_item/post_item.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_bloc/home_bloc.dart';
import 'model/post.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !PreventLoadOverlapFlag.isLoading) {
      context.read<HomeBloc>().add(LoadListPost());
      PreventLoadOverlapFlag.turnOn();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.95);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    getIt<GetUserInfoUseCase>()
        .call(SessionUser.token!)
        .then((value) => value.fold((l) => null, (r) {
              CurrentUser.id = r.id!;
              CurrentUser.avatar = r.avatarUrl;
              CurrentUser.userName = r.userName;
            }));
    context.read<HomeBloc>().add(LoadListPost());
  }

  @override
  Widget build(BuildContext context) {
    RefreshController refreshController =
        RefreshController(initialRefresh: false);
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          current.status == HomeStatus.loadedSuccess,
      listener: (context, state) =>
          context.read<ListPostNotify>().addOnList(state.itemList!),
      child: Container(
        color: Colors.grey,
        margin: const EdgeInsets.only(top: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                if (state.status == HomeStatus.loading &&
                    state.pageIndex == 0) {
                  return Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Wrap(
                        children: const [
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  );
                }
                return Consumer<ListPostNotify>(
                  builder: (context, value, child) => Expanded(
                    child: SmartRefresher(
                      controller: refreshController,
                      enablePullDown: true,
                      footer: CustomFooter(
                        builder: (__, _) {
                          return Container();
                        },
                      ),
                      header: const WaterDropMaterialHeader(),
                      onRefresh: () {
                        context.read<HomeBloc>().add(ResetListPost());
                        context.read<ListPostNotify>().assignList([]);
                        context.read<HomeBloc>().add(LoadListPost());
                      },
                      child: ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                        shrinkWrap: true,
                        itemCount: value.items.length,
                        itemBuilder: (context, index) => Container(
                            color: Colors.white,
                            child: PostItem(
                              post: value.items[index],
                              index: index,
                            )),
                      ),
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                if (state.status == HomeStatus.loading) {
                  return Container(
                    width: double.infinity,
                    height: double.minPositive,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Wrap(
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListPostNotify with ChangeNotifier {
  List<Post> items = [];

  String likeText(int index) {
    if (index < items.length) {
      var model = items[index];
      var likeNumber = model.likesNumber;
      var isSelfLiking = model.isSelfLiking;
      if (likeNumber == 0) {
        return '0';
      }
      if (likeNumber == 1) {
        if (isSelfLiking) return 'You';
        return '1';
      }
      return isSelfLiking
          ? 'You and ${likeNumber - 1} other'
          : likeNumber.toString();
    }
    return '';
  }

  void assignList(List<Post> newItems) {
    items = newItems;
    notifyListeners();
  }

  void addOnList(List<Post> newItems) {
    items.addAll(newItems);
    notifyListeners();
  }

  void addPost(Post post) {
    items.insert(0, post);
    notifyListeners();
  }

  void likeOnPost(int index) {
    var newItem = items[index];
    if (newItem.isSelfLiking) {
      newItem = newItem.copyWith(
          isSelfLiking: false, likesNumber: newItem.likesNumber - 1);
    } else {
      newItem = newItem.copyWith(
          isSelfLiking: true, likesNumber: newItem.likesNumber + 1);
    }
    items[index] = newItem;
    notifyListeners();
  }

  void commentOnPost(int index) {
    var newItem =
        items[index].copyWith(commentsNumber: items[index].commentsNumber + 1);
    items[index] = newItem;
    notifyListeners();
  }
}

class PreventLoadOverlapFlag {
  static bool isLoading = false;
  static void turnOn() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;
  }
}
