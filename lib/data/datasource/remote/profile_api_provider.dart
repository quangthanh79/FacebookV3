

import 'package:facebook_auth/base/base_client.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/session_user.dart';

import '../../../exception/fetch_data_exception.dart';
import '../../models/change_password_response.dart';
import 'package:facebook_auth/data/models/error_response.dart';
import 'package:facebook_auth/exception/not_data_exception.dart';
import 'package:facebook_auth/utils/json_utils.dart';


import 'package:http/http.dart' as http;

class ProfileApiProvider extends BaseClient{

  @override
  Future<dynamic> post(String url, dynamic body) async{
    url = baseUrl + url;
    final response = await http
        .post(
        Uri.parse(url).replace(queryParameters: body)
    ).timeout(const Duration(seconds: 30));

      if (response.statusCode <= 500) {
        dynamic resultJson = jsonDecodeUtf8(response.bodyBytes);
        ErrorResponse errorResponse = ErrorResponse.fromJson(resultJson);
        if(errorResponse.code == "1011"){
          throw NotDataException("Conversation not existed");
        }
    }
    return jsonDecodeUtf8(response.bodyBytes);
  }


  Future<Optional> signOut() async{
    var url = "auth/logout";
    String? token = SessionUser.token;
    final response = await post(
      url,
      {"token": token}
    );

    if(response != null) return Optional.success;
    return Optional.error;
  }

  Future<ChangePasswordResponse?> changePassword(String curPass, String newPass) async{
    var url = "auth/change_password";
    String? token = SessionUser.token;
    final response = await post(
        url,
        {"token": token, "password": curPass, "new_password": newPass}
            .map((key, value) => MapEntry(key, value.toString()))
    );

    if(response != null)
      return ChangePasswordResponse.fromJson(response);
    return null;
  }
}