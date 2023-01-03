


import 'package:facebook_auth/base/base_client.dart';
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/utils/session_user.dart';

class FriendApiProvider extends BaseClient{

  Future<ResponseListFriend?> getRequestedFriends(int index, int count) async {
    var url = "friend/get_requested_friends";
    final response = await post(
        url,
        {"token": SessionUser.token,"index": index, "count": count}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseListFriend.fromJson(response);
    return null;
  }

  Future<ResponseListFriend?> getListSuggestedFriends(int index, int count) async{
    var url = "friend/get_list_suggested_friends";
    final response = await post(
        url,
        {"token": SessionUser.token,"index": index, "count": count}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseListFriend.fromJson(response);
    return null;
  }

  Future<ResponseListFriend?> setRequestFriend(String user_id) async{
    var url = "friend/set_request_friend";
    var params = {
      "token" : SessionUser.token, "user_id": user_id
    };
    final response = await post(
        url, params.map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseListFriend.fromJson(response);
    return null;
  }

  Future<ResponseListFriend?> setAcceptFriend(String user_id, bool is_accept) async{
    var url = "friend/set_accept_friend";
    var params = {
      "token" : SessionUser.token, "user_id": user_id , "is_accept" : is_accept?1:0
    };
    final response = await post(
        url, params.map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseListFriend.fromJson(response);
    return null;
  }

  Future<ResponseListFriend?> getUserFriends(String user_id, int page) async{
    var url = "friend/get_user_friends";
    final response = await post(
        url,
        {"token": SessionUser.token,"user_id": user_id, "page": page}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseListFriend.fromJson(response);
    return null;
  }

  Future<ResponseListFriend?> getListBlocks(int index, int count) async{
    var url = "friend/get_list_blocks";
    final response = await post(
        url,
        {"token": SessionUser.token,"index": index, "count": count}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseListFriend.fromJson(response);
    return null;
  }

  Future<ResponseActionFriend?> setBlock(String user_id, int type) async{
    var url = "friend/set_block";
    var params = {
      "token" : SessionUser.token, "user_id": user_id, "type": type
    };
    final response = await post(
        url, params.map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseActionFriend.fromJson(response);
    return null;
  }

}
final friendApiProvider = FriendApiProvider();

