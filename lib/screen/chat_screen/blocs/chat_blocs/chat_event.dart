import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable{
  const ChatEvent();
  @override
  List<Object?> get props => [];
}
class LoadListConversationChanged extends ChatEvent{
  const LoadListConversationChanged();
  @override
  List<Object?> get props => [];

}
