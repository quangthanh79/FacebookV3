
import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/data/models/chat_detail.dart';
import 'package:facebook_auth/data/repository/chat_repository.dart';
import 'package:facebook_auth/exception/not_data_exception.dart';
import 'package:facebook_auth/main.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_blocs/chat_state.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_detail_blocs/chat_detail_event.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_detail_blocs/chat_detail_state.dart';

import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent,ChatDetailState>{
  final ChatRepository chatRepository;
  final Partner partner;
  ChatDetailBloc(this.chatRepository,this.partner): super(ChatDetailState()){
    connectSocket();
    on<SendMessageChanged>(_sendMessage);
    on<BindingResumeChanged>(_setReadMessage);
    on<WidthInputChanged>(_changeWidthInput);
  }


  Future<ResponseChatDetail?> getDetailConversation(String partner_id) async {
    try{
      final resultDetailConversation = await chatRepository.getDetailConversation(-1, partner_id);
      final resultSetReadMessage = await chatRepository.setReadMessage(partner_id);

      if (resultDetailConversation != null && resultSetReadMessage != null) {
        return resultDetailConversation;
      } else {
        return null;
      }
    }on NotDataException catch(_){
      return ResponseChatDetail(data: []);
    }
  }


  Future<void> _sendMessage(
      SendMessageChanged event,
      Emitter<ChatDetailState> emit
      ) async{
    print("-------------------EMIT TIN NHAN MOI: "+ event.message);
    var newMessageDetail = MessageDetail(
        message: event.message,
        unread: "1",
        sender: Sender(
            id: SessionUser.idUser
        )
    );
    var newCountMessage = state.countMessage+1;
    print("OLD COUNT MESSAGE: "+ newCountMessage.toString());
    emit(state.copyWith(
        message: newMessageDetail,
        countMessage: ++state.countMessage
    ));

    final result = await chatRepository.sendMessage(event.message,event.partner_id);
    if(result != null){
      print("---------------------");
      print("Bạn gửi tin nhắn thành công: "+ event.message);

    }
  }

  Future<void> _setReadMessage(
      BindingResumeChanged event,
      Emitter<ChatDetailState> emit
      ) async{
    print("-------------------CHAT DETAIL BLOC: SET READ MESSAGE-------------------");

    final result = await chatRepository.setReadMessage(event.partner_id);
    if(result != null){
      print("CHAT DETAIL BLOC: Set read message success: ");
    }
  }
  void _changeWidthInput(
      WidthInputChanged event,
      Emitter<ChatDetailState> emit
      ){
    emit(state.copyWith(
      statusWidthInput: event.widthInput
    ));
  }

  Future<bool> connectSocket() async{
    if(SessionUser.idUser != null){
      print(SessionUser.idUser);
      socketDetailConversation.on('connection',(client){
        print('connection /some');
      });
      socketDetailConversation.on('fromServer', (_) => print(_));
      socketDetailConversation.on(SessionUser.idUser!, (data) async {
        final dataList = data as List;
        print("SOCKET:"+dataList.toString());

        var newMessageDetail = MessageDetail(
            message: dataList[1] as String,
            unread: "1",
            sender: Sender(
                id: dataList[0] as String,
                avatar: partner.avatar
            )
        );
        var newCountMessage = state.countMessage+1;
        print("OLD COUNT MESSAGE: "+ newCountMessage.toString());
        emit(state.copyWith(
            message: newMessageDetail,
            statusHasMessgage: StatusHasMessgage.ReceiveMessage,
            countMessage: newCountMessage
        ));
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
}