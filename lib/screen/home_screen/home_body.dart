// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:facebook_auth/core/helper/current_user.dart';
import 'package:facebook_auth/data/repository/post_repository_impl.dart';
import 'package:facebook_auth/domain/use_cases/get_user_info_use_case.dart';
import 'package:facebook_auth/screen/home_screen/post_item/post_item.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/session_user.dart';

import 'home_bloc/home_bloc.dart';
import 'model/post.dart';

class HomeBody extends StatefulWidget {
  final PostType type;
  final String? keyword;
  const HomeBody({
    Key? key,
    required this.type,
    this.keyword,
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
      context.read<HomeBloc>().add(LoadListPost(keyword: widget.keyword));
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
    context.read<HomeBloc>().add(DisposePost(context: context));
    context.read<HomeBloc>().add(MakeTypePost(type: widget.type));
    _scrollController.addListener(_onScroll);
    getIt<GetUserInfoUseCase>()
        .call(SessionUser.token!)
        .then((value) => value.fold((l) => null, (r) {
              CurrentUser.id = r.id!;
              CurrentUser.avatar = r.avatarUrl;
              CurrentUser.userName = r.userName;
            }));
    context.read<HomeBloc>().add(LoadListPost(keyword: widget.keyword));
  }

  @override
  Widget build(BuildContext context) {
    RefreshController refreshController =
        RefreshController(initialRefresh: false);
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          current.status == HomeStatus.loadedSuccess,
      listener: (context, state) => context
          .read<ListPostNotify>()
          .addOnList(state.itemList!, widget.type),
      child: Container(
        color: Colors.grey,
        margin: EdgeInsets.only(top: widget.type == PostType.home ? 100 : 0),
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
                    builder: (context, value, child) {
                  List<Post> items;
                  switch (widget.type) {
                    case PostType.home:
                      items = value.itemsHome;
                      break;
                    case PostType.profile:
                      items = value.itemsProfile;
                      break;
                    case PostType.search:
                      items = value.itemsSearch;
                      break;
                    case PostType.video:
                      items = value.itemsVideo;
                      break;
                    default:
                      items = value.itemsHome;
                  }
                  return Expanded(
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
                        context
                            .read<ListPostNotify>()
                            .assignList([], widget.type);
                        context
                            .read<HomeBloc>()
                            .add(LoadListPost(keyword: widget.keyword));
                      },
                      child: ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) => Container(
                            color: Colors.white,
                            child: PostItem(
                              type: widget.type,
                              post: items[index],
                              index: index,
                            )),
                      ),
                    ),
                  );
                });
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
  List<Post> itemsHome = [];
  List<Post> itemsVideo = [];
  List<Post> itemsSearch = [];
  List<Post> itemsProfile = [];

  String likeText(int index, PostType type) {
    List<Post> items;
    switch (type) {
      case PostType.home:
        items = itemsHome;
        break;
      case PostType.profile:
        items = itemsProfile;
        break;
      case PostType.search:
        items = itemsSearch;
        break;
      case PostType.video:
        items = itemsVideo;
        break;
      default:
        items = itemsHome;
    }
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

  void assignList(List<Post> newItems, PostType type) {
    switch (type) {
      case PostType.home:
        itemsHome = newItems;
        break;
      case PostType.profile:
        itemsProfile = newItems;
        break;
      case PostType.search:
        itemsSearch = newItems;
        break;
      case PostType.video:
        itemsVideo = newItems;
        break;
      default:
        itemsHome = newItems;
    }
    notifyListeners();
  }

  void addOnList(List<Post> newItems, PostType type) {
    switch (type) {
      case PostType.home:
        itemsHome.addAll(newItems);
        break;
      case PostType.profile:
        itemsProfile.addAll(newItems);
        break;
      case PostType.search:
        itemsSearch.addAll(newItems);
        break;
      case PostType.video:
        itemsVideo.addAll(newItems);
        break;
      default:
        itemsHome.addAll(newItems);
    }
    notifyListeners();
  }

  void addPost(Post post, PostType type) {
    switch (type) {
      case PostType.home:
        itemsHome.insert(0, post);
        break;
      case PostType.profile:
        itemsProfile.insert(0, post);
        break;
      case PostType.search:
        itemsSearch.insert(0, post);
        break;
      case PostType.video:
        itemsVideo.insert(0, post);
        break;
      default:
        itemsHome.insert(0, post);
    }
    notifyListeners();
  }

  void likeOnPost(int index, PostType type) {
    List<Post> items;
    switch (type) {
      case PostType.home:
        items = itemsHome;
        break;
      case PostType.profile:
        items = itemsProfile;
        break;
      case PostType.search:
        items = itemsSearch;
        break;
      case PostType.video:
        items = itemsVideo;
        break;
      default:
        items = itemsHome;
    }
    var newItem = items[index];
    if (newItem.isSelfLiking) {
      newItem = newItem.copyWith(
          isSelfLiking: false, likesNumber: newItem.likesNumber - 1);
    } else {
      newItem = newItem.copyWith(
          isSelfLiking: true, likesNumber: newItem.likesNumber + 1);
    }
    switch (type) {
      case PostType.home:
        itemsHome[index] = newItem;
        break;
      case PostType.profile:
        itemsProfile[index] = newItem;
        break;
      case PostType.search:
        itemsSearch[index] = newItem;
        break;
      case PostType.video:
        itemsVideo[index] = newItem;
        break;
      default:
        itemsHome[index] = newItem;
    }
    notifyListeners();
  }

  void commentOnPost(int index, PostType type) {
    List<Post> items;
    switch (type) {
      case PostType.home:
        items = itemsHome;
        break;
      case PostType.profile:
        items = itemsProfile;
        break;
      case PostType.search:
        items = itemsSearch;
        break;
      case PostType.video:
        items = itemsVideo;
        break;
      default:
        items = itemsHome;
    }
    var newItem =
        items[index].copyWith(commentsNumber: items[index].commentsNumber + 1);
    switch (type) {
      case PostType.home:
        itemsHome[index] = newItem;
        break;
      case PostType.profile:
        itemsProfile[index] = newItem;
        break;
      case PostType.search:
        itemsSearch[index] = newItem;
        break;
      case PostType.video:
        itemsVideo[index] = newItem;
        break;
      default:
        itemsHome[index] = newItem;
    }
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
