// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loadedSuccess, loadedFailure }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? error;
  final List<Post>? itemList;
  final int pageIndex;

  const HomeState({
    this.status = HomeStatus.initial,
    this.error,
    this.itemList,
    this.pageIndex = 0,
  });

  @override
  List<Object?> get props => [status, itemList, error, pageIndex];

  HomeState copyWith({
    HomeStatus? status,
    String? error,
    List<Post>? itemList,
    int? pageIndex,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      itemList: itemList ?? this.itemList,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
