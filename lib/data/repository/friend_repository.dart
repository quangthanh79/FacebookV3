
import '../datasource/remote/friend_api_provider.dart';
import '../models/friend.dart';

class FriendRepository{
  FriendRepository();

  Future<ResponseListFriend?> getRequestedFriends(int index, int count)
    => friendApiProvider.getRequestedFriends(index, count);

  Future<ResponseListFriend?> getListSuggestedFriends(int index, int count)
    => friendApiProvider.getListSuggestedFriends(index, count);

  Future<ResponseListFriend?> setRequestFriend(String user_id)
    => friendApiProvider.setRequestFriend(user_id);

  Future<ResponseListFriend?> setAcceptFriend(String user_id, bool is_accept)
    => friendApiProvider.setAcceptFriend(user_id, is_accept);

  Future<ResponseListFriend?> getUserFriends(String user_id, int page)
    => friendApiProvider.getUserFriends(user_id, page);

  Future<ResponseListFriend?> getListBlocks(int index, int count)
    => friendApiProvider.getListBlocks(index, count);

  Future<ResponseActionFriend?> setBlock(String user_id, int type)
    => friendApiProvider.setBlock(user_id, type);

}