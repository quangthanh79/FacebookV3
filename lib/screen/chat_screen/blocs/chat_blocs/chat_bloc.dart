import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/friend_chat.dart';
import 'package:facebook_auth/data/repository/chat_repository.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/main.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_blocs/chat_event.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_blocs/chat_state.dart';

import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  final FriendRepository friendRepository;
  int flagLoaddata  = 0;


  ChatBloc(this.chatRepository,this.friendRepository) : super(ChatState()) {
    connectSocket();
    on<LoadListConversationChanged>(_loadData);
  }

  Future<void> _loadData(
      LoadListConversationChanged event,
      Emitter<ChatState> emit) async
  {
    emit(state.copyWith(flagLoadData: ++flagLoaddata));
  }

  Future<bool> connectSocket() async{
    if(SessionUser.idUser != null){
      print(SessionUser.idUser);
      socketListConversation.on('connection',(client){
        print('connection /some');
      });
      socketListConversation.on('fromServer', (_) => print(_));
      socketListConversation.on(SessionUser.idUser!, (data) async {
        final dataList = data as List;
        print("SOCKET:"+dataList.toString());

        // var newMessageDetail = MessageDetail(
        //     message: dataList[1] as String,
        //     unread: "1",
        //     sender: Sender(
        //         id: dataList[0] as String,
        //         avatar: partner.avatar
        //     )
        // );
        var newCountMessage = state.countMessage+1;
        print("OLD COUNT MESSAGE: "+ newCountMessage.toString());
        // emit(state.copyWith(
        //     message: newMessageDetail,
        //     statusHasMessgage: StatusHasMessgage.ReceiveMessage,
        //     countMessage: newCountMessage
        // ));
      }
      );
      socketDetailConversation.connect();
      socketDetailConversation.emit("disconect","Pham Quang Thanh");
      print("sokectttt");
      return true;
    }else{
      return false;
    }
  }

  Future<ResponseListConversation?> tryFetchListConversation(int page) async {
    try {
      ResponseListConversation? responseFetchListConversation = await chatRepository.getListConversation(page);
      if(responseFetchListConversation != null){
        return responseFetchListConversation;
      }else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
  Future<ResponseUserFriendsChat?> tryFetchListFriend(int page) async {
    try {
      ResponseUserFriendsChat? responseFetchListFriendChat = await chatRepository.getUserFriends(SessionUser.idUser!, page);
      if(responseFetchListFriendChat != null){
        return responseFetchListFriendChat;
      }else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
