// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loadedSuccess, loadedFailure }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? error;
  final List<Post>? itemList;
  final int pageIndex;
  final PostType type;
  final bool isNoInternetFirstLoad;
  final BuildContext? context;

  const HomeState({
    this.status = HomeStatus.initial,
    this.error,
    this.itemList,
    this.pageIndex = 0,
    this.type = PostType.home,
    this.isNoInternetFirstLoad = true,
    this.context,
  });

  @override
  List<Object?> get props => [
        status,
        itemList,
        error,
        pageIndex,
        isNoInternetFirstLoad,
        type,
        context
      ];

  HomeState copyWith({
    HomeStatus? status,
    String? error,
    List<Post>? itemList,
    int? pageIndex,
    PostType? type,
    bool? isNoInternetFirstLoad,
    BuildContext? context,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      itemList: itemList ?? this.itemList,
      pageIndex: pageIndex ?? this.pageIndex,
      type: type ?? this.type,
      isNoInternetFirstLoad:
          isNoInternetFirstLoad ?? this.isNoInternetFirstLoad,
      context: context ?? this.context,
    );
  }
}
