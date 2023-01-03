
import 'package:equatable/equatable.dart';
import 'package:facebook_auth/data/models/chat.dart';
import 'package:formz/formz.dart';

enum StatusHasMessgage{pure,SendMessage,ReceiveMessage}
class ChatState extends Equatable{
  final FormzStatus loadListConversationStatus;
  final List<Conversation> listConversation;
  int countMessage;
  int flagLoadData;
  final StatusHasMessgage statusHasMessgage;
  ChatState({
    this.loadListConversationStatus = FormzStatus.pure,
    this.listConversation = const [],
    this.statusHasMessgage = StatusHasMessgage.pure,
    this.flagLoadData = 0,
    this.countMessage = 0,
});
  @override
  List<Object?> get props => [this.loadListConversationStatus,this.statusHasMessgage,this.flagLoadData,this.listConversation,this.countMessage];

  ChatState copyWith(
      {FormzStatus? loadListConversationStatus,
       FormzStatus? sendMessageStatus,
       List<Conversation>? listConversation,
       StatusHasMessgage? statusHasMessgage,
       int? flagLoadData,
       int? countMessage,
       String? message
      }) {
    return ChatState(
        loadListConversationStatus: loadListConversationStatus ?? this.loadListConversationStatus,
        listConversation: listConversation ?? this.listConversation,
        statusHasMessgage: statusHasMessgage ?? this.statusHasMessgage,
        flagLoadData: flagLoadData ?? this.flagLoadData,
        countMessage: countMessage ?? this.countMessage,);
  }
}