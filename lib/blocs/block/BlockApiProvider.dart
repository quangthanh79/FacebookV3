

import 'package:facebook_auth/base/base_client.dart';
import 'package:facebook_auth/blocs/block/BlockModel.dart';

import '../../data/models/unblock_response.dart';

class BlockApiProvider extends BaseClient{
  Future<BlockModel?> getListBlock(String? token, String index, String count) async{
    var url = 'friend/get_list_blocks';
    final response = await post(
        url,
        {"token": token, "index": index, "count": count}
    );
    if (response != null) return BlockModel.fromJson(response);
  }

  Future<UnBlockResponse?> setUnBlock(String? token, String userId, String type) async{
    var url = 'friend/set_block';
    final response = await post(
        url,
        {"token": token, "user_id": userId, "type": type}
    );
    if (response != null) return UnBlockResponse.fromJson(response);
  }

}