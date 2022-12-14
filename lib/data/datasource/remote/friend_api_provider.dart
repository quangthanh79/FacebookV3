


import 'package:facebook_auth/base/base_client.dart';
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/utils/session_user.dart';

class FriendApiProvider extends BaseClient{
  // String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzODNhN2I3ZGE4YTViZGU4MzljNThjYyIsImRhdGVMb2dpbiI6IjIwMjItMTEtMzBUMTU6Mjg6MTQuMjQyWiIsImlhdCI6MTY2OTgyMjA5NCwiZXhwIjoxNjc5ODIyMDkzfQ.mac6fnO9WAreMl3_numHXMptxCsuP77bETtTYh4TARA";
  String? token = SessionUser.token;

  Future<ResponseListFriend?> getRequestedFriends(int index, int count) async {
    var url = "friend/get_requested_friends";
    final response = await post(
        url,
        {"token": token,"index": index, "count": count}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseListFriend.fromJson(response);
    return null;
  }

  Future<ResponseListFriend?> getListSuggestedFriends(int index, int count) async{
    var url = "friend/get_list_suggested_friends";
    final response = await post(
        url,
        {"token": token,"index": index, "count": count}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseListFriend.fromJson(response);
    return null;
  }

  Future<bool> setRequestFriend(String user_id) async{
    var url = "friend/set_request_friend";
    var params = {
      "token" : token, "user_id": user_id
    };
    final response = await post(
        url, params.map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null && response['code'] == "1000") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setAcceptFriend(String user_id, bool is_accept) async{
    var url = "friend/set_accept_friend";
    var params = {
      "token" : token, "user_id": user_id , "is_accept" : is_accept?1:0
    };
    final response = await post(
        url, params.map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null && response["code"] == "1000") {
      return true;
    } else {
      return false;
    }
  }

  Future<ResponseListFriend?> getUserFriends(String user_id, int page) async{
    var url = "friend/get_user_friends";
    final response = await post(
        url,
        {"token": token,"user_id": user_id, "page": page}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseListFriend.fromJson(response);
    return null;
  }

  Future<ResponseListFriend?> getListBlocks(int index, int count) async{
    var url = "friend/get_list_blocks";
    final response = await post(
        url,
        {"token": token,"index": index, "count": count}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseListFriend.fromJson(response);
    return null;
  }

  Future<bool> setBlock(String user_id, int type) async{
    var url = "friend/set_block";
    var params = {
      "token" : token, "user_id": user_id, "type": type
    };
    final response = await post(
        url, params.map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null && response['code'] == "1000") {
      return true;
    } else {
      return false;
    }
  }

}
final friendApiProvider = FriendApiProvider();

