

import 'package:facebook_auth/base/base_client.dart';
import 'package:facebook_auth/data/models/delete_saved_search_response.dart';
import 'package:facebook_auth/data/models/delete_saved_search_response.dart';
import 'package:facebook_auth/data/models/delete_saved_search_response.dart';
import 'package:facebook_auth/utils/session_user.dart';

import '../../models/get_saved_search_response.dart';

class GetSavedSearchProvider extends BaseClient{

  Future<GetSavedSearchResponse?> getSavedSearch(String? token, String index, String count) async{
    var url = "search/get_saved_search";
    final response = await post(
        url,
        {"token": token, "index": index, "count": count}
    );
    if(response != null) return GetSavedSearchResponse.fromJson(response);
  }

  Future<DeleteSavedSearchResponse?> deleteSavedSearch(String? token, String all, String searchId) async{
    var url = "search/del_saved_search";
    final response = await post(
        url,
        {"token": token, "all": all, "search_id": searchId}
    );
    if(response != null) return DeleteSavedSearchResponse.fromJson(response);
  }
}