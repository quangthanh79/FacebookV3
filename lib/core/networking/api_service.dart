import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facebook_auth/core/helper/no_thing.dart';
import 'package:facebook_auth/data/models/comment_response.dart';
import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/utils/constant.dart' as constant;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

import 'api_response.dart';

part 'api_service.g.dart';

class API {
  static const int connectTimeOut = 15000;
  static const int sendTimeOut = 15000;
  static const int receiveTimeOut = 15000;

  static const String getListPosts = '/post/get_list_posts';
  static const String addPost = '/post/add_post';
  static const String getComment = '/comment/get_comment';
  static const String setComment = '/comment/set_comment';
  static const String like = '/like/like';
}

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
      receiveTimeout: API.receiveTimeOut,
      connectTimeout: API.connectTimeOut,
      sendTimeout: API.sendTimeOut,
    );

    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: false,
      request: false,
      requestBody: true,
    ));
    return _ApiService(dio, baseUrl: constant.baseUrl);
  }

  @POST(API.getListPosts)
  Future<ApiResponse<PostListResponse>> getListPosts(
      {@Query("token") required String token,
      @Query("count") required int count,
      @Query('index') required int index});

  @POST(API.addPost)
  @MultiPart()
  Future<ApiResponse<AddPostResponse>> addPost(
      {@Query("token") required String token,
      @Query("described") required String described,
      @Part(name: 'image') File? image});

  @POST(API.getComment)
  Future<ApiResponse<List<CommentModel>>> getComment(
      {@Query("token") required String token,
      @Query("id") required String postId,
      @Query("count") required int count,
      @Query('index') required int index});

  @POST(API.setComment)
  Future<ApiResponse<List<CommentModel>>> setComment(
      {@Query("token") required String token,
      @Query("id") required String postId,
      @Query("comment") required String comment,
      @Query("count") required int count,
      @Query('index') required int index});

  @POST(API.like)
  Future<ApiResponse<bool>> like({
    @Query("token") required String token,
    @Query("id") required String postId,
  });
}
