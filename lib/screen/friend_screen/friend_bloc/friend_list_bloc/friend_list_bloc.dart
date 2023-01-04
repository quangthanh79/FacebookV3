

import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'friend_list_event.dart';
part 'friend_list_state.dart';

class Key{
  bool is_block = false;
  bool get isBlock => is_block;
  bool get isUnblock => !is_block;
  void block(){
    is_block = true;
  }
  void unblock(){
    is_block = false;
  }
}

class FriendListBloc extends Bloc<FriendListEvent, FriendListState>{
  static const int numFriendsPerPage = 10;
  FriendRepository friendRepository;
  User user;
  List<User> listFriend;

  Key loadMoreKey = Key();

  FriendListBloc({
    required this.user,
    required this.listFriend,
    required this.friendRepository
  }) : super(FriendListState(status: FriendListStatus.LOADING)){
    on<LoadListFriendEvent>(loadFriend);
    on<ReloadListFriendEvent>(reloadFriend);
    on<BackgroundLoadListFriendEvent>(backgroundLoadFriend);
    on<LoadMoreListFriendEvent>(loadMoreListFriend);

    on<LoadListRequestEvent>(loadRequest);
    on<ReloadListRequestEvent>(reloadRequest);
    on<BackgroundLoadListRequestEvent>(backgroundLoadRequest);
    on<LoadMoreListRequestEvent>(loadMoreListRequest);

    on<LoadListSuggestEvent>(loadSuggest);
    on<ReloadListSuggestEvent>(reloadSuggest);
    on<BackgroundLoadListSuggestEvent>(backgroundLoadSuggest);
    on<LoadMoreListSuggestEvent>(loadMoreListSuggest);
  }

  Future<void> loadFriend(LoadListFriendEvent e, Emitter<FriendListState> emit) async{
    emit(FriendListState(status: FriendListStatus.LOADING));
    add(BackgroundLoadListFriendEvent());
  }
  Future<void> reloadFriend(ReloadListFriendEvent e, Emitter<FriendListState> emit) async{
    if (listFriend.isEmpty){
      emit(FriendListState(status: FriendListStatus.NO_FRIENDS));
    } else {
      emit(FriendListState(status: FriendListStatus.LOADED));
    }
  }
  Future<void> backgroundLoadFriend(BackgroundLoadListFriendEvent e, Emitter<FriendListState> emit) async{
    // get 2 pages
    ResponseListFriend? responseListFriend1, responseListFriend2;
    await Future.wait([
      Future( () async {
        responseListFriend1 = await friendRepository.getUserFriends(user.id!, 1);
      }),
      Future( () async {
        responseListFriend2 = await friendRepository.getUserFriends(user.id!, 2);
      }),
    ]);
    listFriend.clear();
    // combines to listFriend:
    if (responseListFriend1 != null && responseListFriend1!.data != null){
      for (var element in responseListFriend1!.data!.list!) {
        listFriend.add(User(id: element.user_id, same_friends: element.same_friends ?? 0));
      }
    }
    if (responseListFriend2 != null && responseListFriend2!.data != null){
      for (var element in responseListFriend2!.data!.list!) {
        listFriend.add(User(id: element.user_id, same_friends: element.same_friends ?? 0));
      }
    }
    add(ReloadListFriendEvent());
  }
  Future<void> loadMoreListFriend(LoadMoreListFriendEvent e, Emitter<FriendListState> emit) async{
    if (loadMoreKey.isBlock) return;
    loadMoreKey.block();

    int currentNumFriends = listFriend.length;
    int currentPages = ((currentNumFriends - 1) / numFriendsPerPage).floor();

    ResponseListFriend? responseListFriend = await friendRepository.getUserFriends(user.id!, currentPages + 1);
    if (responseListFriend != null && responseListFriend.code == "1000"){
      List<Friend> lsFriend = responseListFriend.data!.list!;
      if (lsFriend.isNotEmpty){
        for (var element in lsFriend) {
          listFriend.add(User(id: element.user_id, same_friends: element.same_friends ?? 0));
        }
      } else {
        return;
      }
    }

    add(ReloadListFriendEvent());

    loadMoreKey.unblock();
  }


  Future<void> loadRequest(LoadListRequestEvent e, Emitter<FriendListState> emit) async{
    emit(FriendListState(status: FriendListStatus.LOADING));
    add(BackgroundLoadListRequestEvent());
  }
  Future<void> reloadRequest(ReloadListRequestEvent e, Emitter<FriendListState> emit) async{
    if (listFriend.isEmpty){
      emit(FriendListState(status: FriendListStatus.NO_FRIENDS));
    } else {
      emit(FriendListState(status: FriendListStatus.LOADED));
    }
  }
  Future<void> backgroundLoadRequest(BackgroundLoadListRequestEvent e, Emitter<FriendListState> emit) async{
    ResponseListFriend? responseListFriend1;
    await Future.wait([
      Future( () async {
        responseListFriend1 = await friendRepository.getRequestedFriends(0, 100);
      }),
    ]);
    listFriend.clear();
    // combines to listFriend:
    if (responseListFriend1 != null && responseListFriend1!.data != null){
      for (var element in responseListFriend1!.data!.list!) {
        listFriend.add(User(id: element.user_id, same_friends: element.same_friends ?? 0));
      }
    }
    add(ReloadListRequestEvent());
  }

  Future<void> loadMoreListRequest(LoadMoreListRequestEvent e, Emitter<FriendListState> emit) async{
    if (loadMoreKey.isBlock) return;
    loadMoreKey.block();

    int currentNumFriends = listFriend.length;

    ResponseListFriend? responseListFriend = await friendRepository.getRequestedFriends(currentNumFriends, 10);
    if (responseListFriend != null && responseListFriend.code == "1000"){
      List<Friend> lsFriend = responseListFriend.data!.list!;
      if (lsFriend.isNotEmpty){
        for (var element in lsFriend) {
          listFriend.add(User(id: element.user_id, same_friends: element.same_friends ?? 0));
        }
      } else {
        return;
      }
    }

    add(ReloadListFriendEvent());

    loadMoreKey.unblock();
  }


  Future<void> loadSuggest(LoadListSuggestEvent e, Emitter<FriendListState> emit) async{
    emit(FriendListState(status: FriendListStatus.LOADING));
    add(BackgroundLoadListSuggestEvent());
  }
  Future<void> reloadSuggest(ReloadListSuggestEvent e, Emitter<FriendListState> emit) async{
    if (listFriend.isEmpty){
      emit(FriendListState(status: FriendListStatus.NO_FRIENDS));
    } else {
      emit(FriendListState(status: FriendListStatus.LOADED));
    }
  }
  Future<void> backgroundLoadSuggest(BackgroundLoadListSuggestEvent e, Emitter<FriendListState> emit) async{
    ResponseListFriend? responseListFriend1;
    await Future.wait([
      Future( () async {
        responseListFriend1 = await friendRepository.getListSuggestedFriends(0, 100);
      }),
    ]);
    listFriend.clear();
    // combines to listFriend:
    if (responseListFriend1 != null && responseListFriend1!.data != null){
      for (var element in responseListFriend1!.data!.list!) {
        listFriend.add(User(id: element.user_id, same_friends: element.same_friends ?? 0));
      }
      // listFriend.removeWhere((element) {
      //   return element.is_friend == "BLOCKING" || element.is_friend == "BLOCKED";
      // });
    }
    print("total request friends: ${responseListFriend1!.data!.total}");
    add(ReloadListSuggestEvent());
  }
  Future<void> loadMoreListSuggest(LoadMoreListSuggestEvent e, Emitter<FriendListState> emit) async {
    if (loadMoreKey.isBlock) return;
    loadMoreKey.block();

    int currentNumFriends = listFriend.length;

    ResponseListFriend? responseListFriend = await friendRepository.getListSuggestedFriends(currentNumFriends, 2);
    if (responseListFriend != null && responseListFriend.code == "1000"){
      List<Friend> lsFriend = responseListFriend.data!.list!;
      if (lsFriend.isNotEmpty){
        for (var element in lsFriend) {
          listFriend.add(User(id: element.user_id, same_friends: element.same_friends ?? 0));
        }
      } else {
        return;
      }
    }

    add(ReloadListFriendEvent());

    loadMoreKey.unblock();
  }
}