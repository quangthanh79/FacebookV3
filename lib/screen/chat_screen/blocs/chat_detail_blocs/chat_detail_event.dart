import 'package:equatable/equatable.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_detail_blocs/chat_detail_state.dart';

abstract class ChatDetailEvent extends Equatable{
  const ChatDetailEvent();
  @override
  List<Object?> get props => [];
}
class LoadConversationDetailChanged extends ChatDetailEvent{
  final String partner_id;
  const LoadConversationDetailChanged(this.partner_id);
  @override
  List<Object?> get props => [this.partner_id];

}

class SendMessageChanged extends ChatDetailEvent{
  final String message;
  final String partner_id;
  const SendMessageChanged(this.message,this.partner_id);
  @override
  List<Object?> get props => [this.message,this.partner_id];
}
class BindingResumeChanged extends ChatDetailEvent{
  final String partner_id;

  const BindingResumeChanged(this.partner_id);
  @override
  List<Object?> get props => [this.partner_id];
}
class WidthInputChanged extends ChatDetailEvent{
  final WidthInput widthInput;
  const WidthInputChanged(this.widthInput);
  @override
  List<Object?> get props => [this.widthInput];
}