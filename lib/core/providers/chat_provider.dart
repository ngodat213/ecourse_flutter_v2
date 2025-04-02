import 'package:ecourse_flutter_v2/app/data/models/chat_model.dart';
import 'package:flutter/material.dart';
import '../../services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();

  ChatService get chatService => _chatService;
  List<ChatModel> get messages => _chatService.messages;
  Map<String, bool> get typingUsers => _chatService.typingUsers;
  bool get isConnected => _chatService.isConnected;

  void joinConversation(String conversationId) {
    _chatService.joinConversation(conversationId);
  }

  void leaveConversation() {
    _chatService.leaveCurrentConversation();
  }

  void sendMessage(String content, {String contentType = 'text'}) {
    _chatService.sendMessage(content, contentType: contentType);
  }

  void sendImage(String base64Image, {String caption = ''}) {
    _chatService.sendImage(base64Image, caption: caption);
  }

  void sendTypingStatus() {
    _chatService.sendTypingStatus();
  }

  void stopTypingStatus() {
    _chatService.stopTypingStatus();
  }

  @override
  void dispose() {
    _chatService.dispose();
    super.dispose();
  }
}
