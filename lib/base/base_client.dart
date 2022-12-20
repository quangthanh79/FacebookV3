

import 'dart:io';

import 'package:facebook_auth/data/models/error_response.dart';
import 'package:facebook_auth/exception/not_data_exception.dart';
import 'package:facebook_auth/utils/json_utils.dart';

import '../exception/fetch_data_exception.dart';
import '../utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';



class BaseClient {
  Future<dynamic> get(String url) async{
      return true;
  }
  Future<dynamic> getWithCache(String url) async{
    return true;
  }

  Future<dynamic> post(String url, dynamic body) async{
      url = baseUrl + url;
      print("API post: $url "+ body.toString());

      final response = await http
          .post(
              Uri.parse(url).replace(queryParameters: body)
            ).timeout(const Duration(seconds: 30));
      print("BASE CLIENT: "+ response.body.toString());

      if(response.statusCode == 200){
        return jsonDecodeUtf8(response.bodyBytes);
      } else {
        if (response.statusCode <= 500) {
          dynamic resultJson = jsonDecodeUtf8(response.bodyBytes);
          ErrorResponse errorResponse = ErrorResponse.fromJson(resultJson);
          if(errorResponse.code == "1011"){
            throw NotDataException("Conversation not existed");
          }
          print(response.body);
          return null;
        }
        throw FetchDataException("Post request failed");
      }
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> post_with_file(String url, dynamic body, Map<String, File> files) async{
    url = baseUrl + url;
    print("API post: $url");

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(url).replace(queryParameters: body));

    files.forEach((key, value) {
      request.files.add(
          http.MultipartFile(
              key,
              value.readAsBytes().asStream(),
              value.lengthSync(),
              filename: value.uri.toString().split('/').last,
              contentType: MediaType('image', 'jpeg')
          )
      );
    });

    var response = await http.Response.fromStream(await request.send());

    print("BASE CLIENT: ${response.body}");
    if(response.statusCode == 200){
      return jsonDecodeUtf8(response.bodyBytes);
    } else {
      if (response.statusCode <= 500) {
        dynamic resultJson = jsonDecodeUtf8(response.bodyBytes);
        ErrorResponse errorResponse = ErrorResponse.fromJson(resultJson);
        if(errorResponse.code == "1011"){
          throw NotDataException("Conversation not existed");
        }
        print(response.body);
        return null;
      }
      throw FetchDataException("Post request failed");
    }
  }
}