import 'package:ecourse_flutter_v2/app/data/repositories/conversation_repository_impl.dart';
import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/chat_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_profile.dart';
import 'package:ecourse_flutter_v2/app/domain/repositories/conversation_repository.dart';
import 'package:ecourse_flutter_v2/app/data/models/conversation_model.dart';
import 'package:ecourse_flutter_v2/core/services/socket_service.dart';
import 'package:ecourse_flutter_v2/enums/message_type.enum.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class ChatVM extends BaseVM {
  final ConversationRepository conversationRepository =
      ConversationRepositoryImpl();
  final SocketService _socketService = SocketService();

  final List<ChatModel> _messages = [];
  final List<ConversationModel> _chats = [];
  UserProfile? _userData;
  bool _isLoading = false;
  String? _error;
  String? _currentConversationId;
  final Map<String, bool> _typingUsers = {};

  // Getters
  List<ChatModel> get messages => _messages;
  List<ConversationModel> get chats => _chats;
  UserProfile? get currentUserId => _userData;
  Map<String, bool> get typingUsers => Map.unmodifiable(_typingUsers);
  bool get isConnected => _socketService.isConnected;
  @override
  bool get isLoading => _isLoading;
  @override
  String? get error => _error;

  ChatVM(super.context) {
    _initSocket();
  }

  Future<void> _initSocket() async {
    await _socketService.initSocket();
    _setupSocketListeners();
  }

  void _setupSocketListeners() {
    _socketService.onNewMessage((data) {
      try {
        if (data['message'] != null &&
            data['message'] is Map<String, dynamic>) {
          final message = ChatModel.fromJson(data['message']);
          if (message.sender?.sId != _userData?.user?.sId) {
            _messages.add(message);
            notifyListeners();
          }
        }
      } catch (e) {
        debugPrint('Error handling new message: $e');
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
      notifyListeners();
    });
  }

  @override
  void onInit() {
    super.onInit();
    _userData = context.read<UserVM>().userProfile;
  }

  @override
  void dispose() {
    if (_currentConversationId != null) {
      _socketService.leaveConversation(_currentConversationId!);
    }
    super.dispose();
  }

  Future<void> loadChatList() async {
    _setLoading(true);

    try {
      // Trong ứng dụng thực tế, gọi API để lấy danh sách chat
      await Future.delayed(const Duration(seconds: 1)); // Mô phỏng delay mạng

      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  Future<void> loadChatDetail(String chatId) async {
    _setLoading(true);
    _currentConversationId = chatId;

    try {
      // Join socket room cho conversation
      _socketService.joinConversation(chatId);

      _messages.clear();
      final response = await conversationRepository.getConversationMessages(
        chatId,
      );
      if (response.allGood) {
        for (var message in response.body) {
          _messages.add(ChatModel.fromJson(message));
        }
      }
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  void sendMessage(String content) {
    if (content.trim().isEmpty || _currentConversationId == null) return;

    // Gửi tin nhắn qua socket
    _socketService.sendMessage(
      _currentConversationId!,
      content,
      contentType: 'text',
    );

    // Thêm tin nhắn local để hiển thị ngay (có thể cập nhật lại khi nhận tin từ socket)
    final newMessage = ChatModel(
      sId: 'temp_${DateTime.now().millisecondsSinceEpoch}',
      conversation: _currentConversationId,
      sender: Sender(sId: _userData?.user?.sId, email: _userData?.user?.email),
      content: content,
      contentType: MessageType.text,
      readBy: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _messages.add(newMessage);
    notifyListeners();
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

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }
}
