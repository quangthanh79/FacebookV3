
import 'package:equatable/equatable.dart';
import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/data/models/chat_detail.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_blocs/chat_state.dart';
import 'package:formz/formz.dart';

enum WidthInput{SHRINK, OVERAGE}
class ChatDetailState extends Equatable{
  final FormzStatus loadDetailConversationStatus;
  final MessageDetail? message;
  final WidthInput statusWidthInput;
  int countMessage;
  final StatusHasMessgage statusHasMessgage;


  ChatDetailState({
    this.loadDetailConversationStatus = FormzStatus.pure,
    this.statusHasMessgage = StatusHasMessgage.pure,
    this.statusWidthInput = WidthInput.SHRINK,
    this.countMessage = 0,
    this.message = null
  });
  @override
  List<Object?> get props => [this.loadDetailConversationStatus,this.statusHasMessgage,this.statusWidthInput,this.countMessage,this.message];

  ChatDetailState copyWith(
      { FormzStatus? loadDetailConversationStatus,
        StatusHasMessgage? statusHasMessgage,
        WidthInput? statusWidthInput,
        int? countMessage,
        MessageDetail? message
      }) {
    return ChatDetailState(
        loadDetailConversationStatus: loadDetailConversationStatus ?? this.loadDetailConversationStatus,
        statusHasMessgage: statusHasMessgage ?? this.statusHasMessgage,
        statusWidthInput: statusWidthInput ?? this.statusWidthInput,
        countMessage: countMessage ?? this.countMessage,
        message: message ?? this.message);
  }
}