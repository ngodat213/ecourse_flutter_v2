import 'dart:convert';
import 'package:ecourse_flutter_v2/app/data/models/chat_model.dart';
import 'package:flutter/foundation.dart';
import '../core/services/socket_service.dart';

class ChatService extends ChangeNotifier {
  final SocketService _socketService = SocketService();
  String? _currentConversationId;
  final List<ChatModel> _messages = [];
  final Map<String, bool> _typingUsers = {};
  bool _isConnected = false;

  List<ChatModel> get messages => List.unmodifiable(_messages);
  Map<String, bool> get typingUsers => Map.unmodifiable(_typingUsers);
  bool get isConnected => _isConnected;

  ChatService() {
    _initSocket();
  }

  Future<void> _initSocket() async {
    await _socketService.initSocket();
    _setupEventListeners();
    _isConnected = _socketService.isConnected;
    notifyListeners();
  }

  void _setupEventListeners() {
    _socketService.onNewMessage((data) {
      if (data['message'] != null) {
        final message = ChatModel.fromJson(data['message']);
        _addMessage(message);
      }
    });

    _socketService.onTyping((data) {
      if (data['userId'] != null &&
          data['conversationId'] == _currentConversationId) {
        _typingUsers[data['userId']] = true;
        notifyListeners();
      }
    });

    _socketService.onStopTyping((data) {
      if (data['userId'] != null && _typingUsers.containsKey(data['userId'])) {
        _typingUsers.remove(data['userId']);
        notifyListeners();
      }
    });

    _socketService.onUserJoined((data) {
      debugPrint('User joined: ${data['user']['name']}');
    });
  }

  void joinConversation(String conversationId) {
    if (_currentConversationId != null &&
        _currentConversationId != conversationId) {
      leaveCurrentConversation();
    }

    _currentConversationId = conversationId;
    _socketService.joinConversation(conversationId);
    _messages.clear();
    notifyListeners();
  }

  void leaveCurrentConversation() {
    if (_currentConversationId != null) {
      _socketService.leaveConversation(_currentConversationId!);
      _currentConversationId = null;
      _messages.clear();
      _typingUsers.clear();
      notifyListeners();
    }
  }

  void sendMessage(String content, {String contentType = 'text'}) {
    if (_currentConversationId == null) return;

    _socketService.sendMessage(
      _currentConversationId!,
      content,
      contentType: contentType,
    );
  }

  void sendImage(String base64Image, {String caption = ''}) {
    if (_currentConversationId == null) return;

    _socketService.sendImage(
      _currentConversationId!,
      base64Image,
      caption: caption,
    );
  }

  void sendTypingStatus() {
    if (_currentConversationId == null) return;

    _socketService.sendTypingStatus(_currentConversationId!);
  }

  void stopTypingStatus() {
    if (_currentConversationId == null) return;

    _socketService.stopTypingStatus(_currentConversationId!);
  }

  void _addMessage(ChatModel message) {
    if (_currentConversationId != message.conversation) return;

    _messages.add(message);
    notifyListeners();
  }

  @override
  void dispose() {
    leaveCurrentConversation();
    _socketService.disconnect();
    super.dispose();
  }
}
