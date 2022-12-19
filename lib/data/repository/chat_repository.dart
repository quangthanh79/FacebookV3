

import 'package:facebook_auth/data/datasource/remote/chat_api_provider.dart';
import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/data/models/chat_detail.dart';
import 'package:facebook_auth/data/models/friend_chat.dart';
import 'package:facebook_auth/utils/injection.dart';

class ChatRepository {
  late ChatApiProvider chatApiProvider;

  ChatRepository init()  {
    this.chatApiProvider = getIt.get<ChatApiProvider>();
    return this;
  }

  Future<bool> sendMessage(String message, String partner_id)=> chatApiProvider.sendMessage(message,partner_id);
  Future<ResponseListConversation?> getListConversation(int page) => chatApiProvider.getListConversation(page);
  Future<ResponseChatDetail?> getDetailConversation(int index, String partner_id) => chatApiProvider.getDetailConversation(index,partner_id);
  Future<bool?> setReadMessage(String partner_id) => chatApiProvider.setReadMessage(partner_id);
  Future<ResponseUserFriendsChat?> getUserFriends(String user_id, int page) => chatApiProvider.getUserFriends(user_id, page);

}