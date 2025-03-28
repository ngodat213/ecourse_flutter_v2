import 'package:ecourse_flutter_v2/core/services/base_api.dart';

abstract class ConversationRepository {
  // Lấy danh sách conversations của user
  Future<ApiResponse> getConversations();

  // Lấy danh sách tin nhắn của một conversation
  Future<ApiResponse> getConversationMessages(String conversationId);

  // Gửi tin nhắn text trong conversation
  Future<ApiResponse> sendMessage({
    required String conversationId,
    required String content,
    String contentType = 'text',
  });

  // Đánh dấu tất cả tin nhắn đã đọc
  Future<ApiResponse> markAsRead(String conversationId);

  // Lấy hoặc tạo chat 1-1 với instructor
  Future<ApiResponse> getOrCreateDirectChat(String instructorId);

  // Kiểm tra quyền tham gia group chat của khóa học
  Future<ApiResponse> checkGroupAccess(String courseId);

  // Tham gia vào group chat
  Future<ApiResponse> joinGroupChat(String conversationId);

  // Upload và gửi tin nhắn hình ảnh
  Future<ApiResponse> sendImageMessage({
    required String conversationId,
    required String imagePath,
    String? caption,
  });
}
