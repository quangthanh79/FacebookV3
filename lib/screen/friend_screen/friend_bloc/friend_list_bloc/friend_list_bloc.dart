

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
  static const int numFriendsPerPage = 20;
  FriendRepository friendRepository;
  User user;
  ListFriend listFriend;

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
    loadMoreKey.unblock();
    if (listFriend.list.isEmpty){
      emit(FriendListState(status: FriendListStatus.NO_FRIENDS));
    } else {
      emit(FriendListState(status: FriendListStatus.LOADED));
    }
  }
  Future<void> backgroundLoadFriend(BackgroundLoadListFriendEvent e, Emitter<FriendListState> emit) async{
    ResponseListFriend? responseListFriend1 = await friendRepository.getUserFriends(user.id!, 1);
    listFriend.clear();
    // combines to listFriend:
    if (responseListFriend1 != null && responseListFriend1.data != null){
      listFriend.append(responseListFriend1.data!);
      listFriend.total = responseListFriend1.data!.total;
    }
    add(ReloadListFriendEvent());
  }
  Future<void> loadMoreListFriend(LoadMoreListFriendEvent e, Emitter<FriendListState> emit) async{
    if (loadMoreKey.isBlock) return;
    loadMoreKey.block();

    int currentNumFriends = listFriend.length;
    int currentPages = ((currentNumFriends - 1) / numFriendsPerPage).floor() + 1;

    ResponseListFriend? responseListFriend = await friendRepository.getUserFriends(user.id!, currentPages + 1);
    if (responseListFriend != null && responseListFriend.code == "1000"){
      List<Friend> lsFriend = responseListFriend.data!.list;
      if (lsFriend.isNotEmpty){
        listFriend.appendList(lsFriend);
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
    loadMoreKey.unblock();
    if (listFriend.isEmpty){
      emit(FriendListState(status: FriendListStatus.NO_FRIENDS));
    } else {
      emit(FriendListState(status: FriendListStatus.LOADED));
    }
  }
  Future<void> backgroundLoadRequest(BackgroundLoadListRequestEvent e, Emitter<FriendListState> emit) async{
    ResponseListFriend? responseListFriend1 = await friendRepository.getRequestedFriends(0, 10);
    listFriend.clear();
    // combines to listFriend:
    if (responseListFriend1 != null && responseListFriend1.data != null){
      listFriend.append(responseListFriend1.data!);
      listFriend.total = responseListFriend1.data!.total;
    }
    add(ReloadListRequestEvent());
  }

  Future<void> loadMoreListRequest(LoadMoreListRequestEvent e, Emitter<FriendListState> emit) async{
    if (loadMoreKey.isBlock) return;
    loadMoreKey.block();

    int currentNumFriends = listFriend.length;

    ResponseListFriend? responseListFriend = await friendRepository.getRequestedFriends(currentNumFriends, 10);
    if (responseListFriend != null && responseListFriend.code == "1000"){
      List<Friend> lsFriend = responseListFriend.data!.list;
      if (lsFriend.isNotEmpty){
        listFriend.appendList(lsFriend);
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
  Future<void> backgroundLoadSuggest(BackgroundLoadListSuggestEvent e, Emitter<FriendListState> emit) async{
    ResponseListFriend? responseListFriend1 = await friendRepository.getListSuggestedFriends(0, 10);
    listFriend.clear();
    if (responseListFriend1 != null && responseListFriend1.data != null){
      listFriend.append(responseListFriend1.data!);
      listFriend.total = responseListFriend1.data!.total;
      // listFriend.removeWhere((element) {
      //   return element.is_friend == "BLOCKING" || element.is_friend == "BLOCKED";
      // });
    }
    add(ReloadListSuggestEvent());
  }
  Future<void> reloadSuggest(ReloadListSuggestEvent e, Emitter<FriendListState> emit) async{
    loadMoreKey.unblock();
    if (listFriend.isEmpty){
      emit(FriendListState(status: FriendListStatus.NO_FRIENDS));
    } else {
      emit(FriendListState(status: FriendListStatus.LOADED));
    }
  }
  Future<void> loadMoreListSuggest(LoadMoreListSuggestEvent e, Emitter<FriendListState> emit) async {
    if (loadMoreKey.isBlock) return;
    loadMoreKey.block();

    int currentNumFriends = listFriend.length;
    ResponseListFriend? responseListFriend = await friendRepository.getListSuggestedFriends(currentNumFriends, 10);
    if (responseListFriend != null && responseListFriend.code == "1000"){
      List<Friend> lsFriend = responseListFriend.data!.list;
      if (lsFriend.isNotEmpty){
        listFriend.appendList(lsFriend);
      } else {
        return;
      }
    }
    add(ReloadListSuggestEvent());

    loadMoreKey.unblock();
  }
}