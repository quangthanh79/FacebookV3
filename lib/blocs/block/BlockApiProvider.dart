

import 'package:facebook_auth/base/base_client.dart';
import 'package:facebook_auth/blocs/block/BlockModel.dart';

class BlockApiProvider extends BaseClient{
  Future<BlockModel?> getListBlock(String? token, String index, String count) async{
    var url = 'friend/get_list_blocks';
    final response = await post(
        url,
        {"token": token, "index": index, "count": count}
    );
    if (response != null) return BlockModel.fromJson(response);
  }
}