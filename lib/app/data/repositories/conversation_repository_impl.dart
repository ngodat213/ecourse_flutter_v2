import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecourse_flutter_v2/app/domain/repositories/conversation_repository.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final BaseAPI _api;

  ConversationRepositoryImpl({BaseAPI? api}) : _api = api ?? BaseAPI();

  @override
  Future<ApiResponse> getConversations() async {
    try {
      final response = await _api.fetchData(
        '/conversations',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<ApiResponse> getConversationMessages(String conversationId) async {
    try {
      final response = await _api.fetchData(
        '/conversations/$conversationId/messages',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<ApiResponse> sendMessage({
    required String conversationId,
    required String content,
    String contentType = 'text',
  }) async {
    try {
      final response = await _api.fetchData(
        '/conversations/message',
        method: ApiMethod.POST,
        body: {
          'conversation': conversationId,
          'content': content,
          'contentType': contentType,
        },
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<ApiResponse> markAsRead(String conversationId) async {
    try {
      final response = await _api.fetchData(
        '/conversations/$conversationId/read',
        method: ApiMethod.POST,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<ApiResponse> getOrCreateDirectChat(String instructorId) async {
    try {
      final response = await _api.fetchData(
        '/conversations/direct/$instructorId',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<ApiResponse> checkGroupAccess(String courseId) async {
    try {
      final response = await _api.fetchData(
        '/conversations/group-access/$courseId',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<ApiResponse> joinGroupChat(String conversationId) async {
    try {
      final response = await _api.fetchData(
        '/conversations/join-group',
        method: ApiMethod.POST,
        body: {'conversationId': conversationId},
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<ApiResponse> sendImageMessage({
    required String conversationId,
    required String imagePath,
    String? caption,
  }) async {
    try {
      // Tạo form data để upload file
      final formData = FormData.fromMap({
        'conversation': conversationId,
        'image': await MultipartFile.fromFile(imagePath),
        if (caption != null) 'caption': caption,
      });

      final response = await _api.fileUpload(
        '/conversations/message/image',
        method: ApiMethod.POST,
        file: File(imagePath).readAsBytesSync(),
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
