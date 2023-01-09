// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facebook_auth/core/networking/api_service.dart';
import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:http_parser/http_parser.dart';
import '../../../core/common/error/exceptions.dart';

abstract class PostDataSource {
  Future<PostListResponse> loadListPosts(
      {required String token, required int count, required int index});
  Future<PostListResponse> loadListPostsInProfile(
      {required String token,
      required int count,
      required int index,
      required String targetId});
  Future<PostListResponse> loadListVideos(
      {required String token, required int count, required int index});
  Future<PostListResponse> searchPost(
      {required String token,
      required int count,
      required int index,
      required String keyword});
  Future<AddPostResponse> addPost(
      {required String token,
      required String described,
      List<File>? image,
      File? video});
  Future<AddPostResponse> editPost(
      {required String token,
      required String id,
      required String described,
      List<File>? image,
      File? video});
  Future<Author> getUserInfo(String token);
  Future<dynamic> deletePost({
    required String token,
    required String postId,
  });
}

class PostDataSourceImpl implements PostDataSource {
  final ApiService apiService;
  PostDataSourceImpl({
    required this.apiService,
  });
  @override
  Future<PostListResponse> loadListPosts(
      {required String token, required int count, required int index}) async {
    try {
      var response = await apiService.getListPosts(
          token: token, count: count, index: index);
      if (response.statusCode == '1000') {
        if (response.data == null) {
          throw ServerException('Post data is null');
        }
        return response.data!;
      }
      throw ServerException(response.messages ?? unexpectedError);
    } on DioError catch (e) {
      throw ServerException.handleError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PostListResponse> loadListPostsInProfile(
      {required String token,
      required int count,
      required int index,
      required String targetId}) async {
    try {
      var response = await apiService.getListPostsInProfile(
          token: token, count: count, index: index, targetId: targetId);
      if (response.statusCode == '1000') {
        if (response.data == null) {
          throw ServerException('Post data is null');
        }
        return response.data!;
      }
      throw ServerException(response.messages ?? unexpectedError);
    } on DioError catch (e) {
      throw ServerException.handleError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PostListResponse> loadListVideos(
      {required String token, required int count, required int index}) async {
    try {
      var response = await apiService.getListVideos(
          token: token, count: count, index: index);
      if (response.statusCode == '1000') {
        if (response.data == null) {
          throw ServerException('Post data is null');
        }
        return response.data!;
      }
      throw ServerException(response.messages ?? unexpectedError);
    } on DioError catch (e) {
      throw ServerException.handleError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PostListResponse> searchPost(
      {required String token,
      required int count,
      required int index,
      required String keyword}) async {
    try {
      var response = await apiService.searchPost(
          keyword: keyword, token: token, count: count, index: index);
      if (response.statusCode == '1000') {
        if (response.data == null) {
          throw ServerException('Post data is null');
        }
        return response.data!;
      }
      throw ServerException(response.messages ?? unexpectedError);
    } on DioError catch (e) {
      throw ServerException.handleError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AddPostResponse> addPost(
      {required String token,
      required String described,
      List<File>? image,
      File? video}) async {
    try {
      List<MultipartFile>? multipartFiles;
      if (image != null) {
        multipartFiles = <MultipartFile>[];

        for (final file in image) {
          final fileBytes = await file.readAsBytes();
          final multipartFile = MultipartFile.fromBytes(
            fileBytes,
            filename: file.path.split('/').last,
            contentType: MediaType('application', 'octet-stream'),
          );
          multipartFiles.add(multipartFile);
        }
      }
      var response = await apiService.addPost(
          token: token,
          described: described,
          image: multipartFiles,
          video: video);
      if (response.statusCode == '1000') {
        return response.data!;
      }
      throw ServerException(response.messages ?? unexpectedError);
    } on DioError catch (e) {
      throw ServerException.handleError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AddPostResponse> editPost(
      {required String token,
      required String id,
      required String described,
      List<File>? image,
      File? video}) async {
    try {
      List<MultipartFile>? multipartFiles;
      if (image != null) {
        multipartFiles = <MultipartFile>[];

        for (final file in image) {
          final fileBytes = await file.readAsBytes();
          final multipartFile = MultipartFile.fromBytes(
            fileBytes,
            filename: file.path.split('/').last,
            contentType: MediaType('application', 'octet-stream'),
          );
          multipartFiles.add(multipartFile);
        }
      }
      var response = await apiService.editPost(
          id: id,
          token: token,
          described: described,
          image: multipartFiles,
          video: video);
      if (response.statusCode == '1000') {
        return response.data!;
      }
      throw ServerException(response.messages ?? unexpectedError);
    } on DioError catch (e) {
      throw ServerException.handleError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Author> getUserInfo(String token) async {
    try {
      var response = await apiService.getUserInfo(token);
      if (response.statusCode == '1000' && response.data != null) {
        return Author(
            avatarUrl: response.data!.avatarUrl,
            userName: response.data!.userName,
            id: response.data!.id);
      }
      throw ServerException(response.messages ?? unexpectedError);
    } on DioError catch (e) {
      throw ServerException.handleError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> deletePost({
    required String token,
    required String postId,
  }) async {
    try {
      var response = await apiService.deletePost(token: token, postId: postId);
      if (response.statusCode == '1000') {
        return response.messages;
      }
      throw ServerException(response.messages ?? unexpectedError);
    } on DioError catch (e) {
      throw ServerException.handleError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
