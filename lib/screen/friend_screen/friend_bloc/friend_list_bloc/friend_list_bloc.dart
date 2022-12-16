

import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_event.dart';
import 'package:facebook_auth/screen/friend_screen/friend_bloc/friend_list_bloc/friend_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendListBloc extends Bloc<FriendListEvent, FriendListState>{
  static const int numFriendsPerPage = 10;
  FriendRepository friendRepository;
  User user;
  ListFriend listFriend;
  FriendListBloc({
    required this.user,
    required this.listFriend,
    required this.friendRepository
  }) : super(FriendListState(status: FriendListStatus.LOADING)){
    on<LoadListFriendEvent>(loadFriend);
    on<ReloadListFriendEvent>(reloadFriend);
    on<BackgroundLoadListFriendEvent>(backgroundLoadFriend);
    on<LoadListFriendInNumberEvent>(loadFriendInNumber);

    on<LoadListRequestEvent>(loadRequest);
    on<ReloadListRequestEvent>(reloadRequest);
    on<BackgroundLoadListRequestEvent>(backgroundLoadRequest);
    on<LoadListRequestInNumberEvent>(loadRequestInNumber);

    on<LoadListSuggestEvent>(loadSuggest);
    on<ReloadListSuggestEvent>(reloadSuggest);
    on<BackgroundLoadListSuggestEvent>(backgroundLoadSuggest);
    on<LoadListSuggestInNumberEvent>(loadSuggestInNumber);
  }

  Future<void> loadFriend(LoadListFriendEvent e, Emitter<FriendListState> emit) async{
    emit(FriendListState(status: FriendListStatus.LOADING));
    add(BackgroundLoadListFriendEvent());
  }
  Future<void> reloadFriend(ReloadListFriendEvent e, Emitter<FriendListState> emit) async{
    if (listFriend.total! <= 0){
      emit(FriendListState(status: FriendListStatus.NO_FRIENDS));
    } else {
      emit(FriendListState(status: FriendListStatus.LOADED));
      print("vào đây");
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
    // combines to listFriend:
    if (responseListFriend1 != null && responseListFriend1!.data != null){
      listFriend.list!.addAll(responseListFriend1!.data!.list!);
    }
    if (responseListFriend2 != null && responseListFriend2!.data != null){
      listFriend.list!.addAll(responseListFriend2!.data!.list!);
    }
    listFriend.total = listFriend.list!.length;
    add(ReloadListFriendEvent());
  }
  Future<void> loadFriendInNumber(LoadListFriendInNumberEvent e, Emitter<FriendListState> emit) async{

  }


  Future<void> loadRequest(LoadListRequestEvent e, Emitter<FriendListState> emit) async{
    emit(FriendListState(status: FriendListStatus.LOADING));

  }
  Future<void> reloadRequest(ReloadListRequestEvent e, Emitter<FriendListState> emit) async{
    if (listFriend.total! <= 0){
      emit(FriendListState(status: FriendListStatus.NO_FRIENDS));
    } else {
      emit(FriendListState(status: FriendListStatus.LOADED));
    }
  }
  Future<void> backgroundLoadRequest(BackgroundLoadListRequestEvent e, Emitter<FriendListState> emit) async{

  }
  Future<void> loadRequestInNumber(LoadListRequestInNumberEvent e, Emitter<FriendListState> emit) async{

  }


  Future<void> loadSuggest(LoadListSuggestEvent e, Emitter<FriendListState> emit) async{
    emit(FriendListState(status: FriendListStatus.LOADING));

  }
  Future<void> reloadSuggest(ReloadListSuggestEvent e, Emitter<FriendListState> emit) async{
    if (listFriend.total! <= 0){
      emit(FriendListState(status: FriendListStatus.NO_FRIENDS));
    } else {
      emit(FriendListState(status: FriendListStatus.LOADED));
    }
  }
  Future<void> backgroundLoadSuggest(BackgroundLoadListSuggestEvent e, Emitter<FriendListState> emit) async{

  }
  Future<void> loadSuggestInNumber(LoadListSuggestInNumberEvent e, Emitter<FriendListState> emit) async{

  }

}