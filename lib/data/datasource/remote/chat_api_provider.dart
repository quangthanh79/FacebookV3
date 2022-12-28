

import 'package:facebook_auth/base/base_client.dart';
import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/data/models/chat_detail.dart';
import 'package:facebook_auth/data/models/friend_chat.dart';
import 'package:facebook_auth/utils/session_user.dart';

class ChatApiProvider extends BaseClient{
  Future<bool> sendMessage(String message,String partner_id) async {
    String? token = SessionUser.token;
    var url = "chat/add_dialog";
    final response = await post(
        url,
        {"token": token,"partner_id": partner_id,"message": message}
        .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return true;
    else return false;
  }

  Future<ResponseListConversation?> getListConversation(int page) async {
    String? token = SessionUser.token;
    print("Token: "+ token.toString());
    var url = "chat/get_list_conversation";
    final response = await post(
        url,
        {"token": token,"page": page}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseListConversation.fromJson(response);
  }
  Future<ResponseChatDetail?> getDetailConversation(int index,String partner_id) async {
    String? token = SessionUser.token;
    print("Token: "+ token.toString());
    var url = "chat/get_conversation";
    final response = await post(
        url,
        {"token": token,"indexLast": index,"partner_id": partner_id}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseChatDetail.fromJson(response);
  }
  Future<bool?> setReadMessage(String partner_id) async {
    String? token = SessionUser.token;
    print("Token: "+ token.toString());
    var url = "chat/set_read_message";
    final response = await post(
        url,
        {"token": token,"partner_id": partner_id}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return true;
  }
  Future<ResponseUserFriendsChat?> getUserFriends(String user_id, int page) async{
    var url = "friend/get_user_friends";
    String? token = SessionUser.token;
    final response = await post(
        url,
        {"token": token,"user_id": user_id, "page": page}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseUserFriendsChat.fromJson(response);
    return null;
  }
}
