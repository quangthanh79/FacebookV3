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

  ChatBloc(this.chatRepository,this.friendRepository) : super(ChatState()) {
    // connectSocket();
    // on<LoadListConversationChanged>(_getListConversation);
  }

  // Future<void> _getListConversation(
  //     LoadListConversationChanged event, Emitter<ChatState> emit) async {
  //   emit(state.copyWith(loadListConversationStatus: FormzStatus.submissionInProgress));
  //   final resultListConversation = await chatRepository.getListConversation(0, 20);
  //   if(resultListConversation != null){
  //     emit(state.copyWith(loadListConversationStatus: FormzStatus.submissionSuccess,listConversation: resultListConversation.data));
  //     print(" Get List Conversation Success!!");
  //     print(resultListConversation);
  //   } else{
  //     emit(state.copyWith(loadListConversationStatus: FormzStatus.submissionFailure));
  //     print(" Get List Conversation Error!!");
  //   }
  // }
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
  // Future<bool> connectSocket() async{
  //   if(SessionUser.idUser != null){
  //     print(SessionUser.idUser);
  //     socketDetailConversation.on('connection',(client){
  //       print('connection /some');
  //     });
  //     socketDetailConversation.on('fromServer', (_) => print(_));
  //     socketDetailConversation.on(SessionUser.idUser!, (data) {
  //       final dataList = data as List;
  //       print(dataList.toString());
  //       emit(state.copyWith(
  //         message: (dataList[0] as String) + ":" + (dataList[1] as String),
  //         statusHasMessgage: StatusHasMessgage.hasNewMessage,
  //         countMessage: state.countMessage++
  //       ));
  //     }
  //     );
  //     socketDetailConversation.connect();
  //     socketDetailConversation.emit("disconect","Pham Quang Thanh");
  //     print("sokectttt");
  //     return true;
  //   }else{
  //     return false;
  //   }
  // }
}
