import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/models/chat_model.dart';

class ChatVM extends BaseVM {
  List<MessageModel> _messages = [];
  List<ChatModel> _chats = [];
  final String _currentUserId =
      'current_user_id'; // Giả lập ID người dùng hiện tại
  bool _isLoading = false;
  String? _error;

  // Getters
  List<MessageModel> get messages => _messages;
  List<ChatModel> get chats => _chats;
  String get currentUserId => _currentUserId;
  @override
  bool get isLoading => _isLoading;
  @override
  String? get error => _error;

  ChatVM(super.context) {
    // Khởi tạo dữ liệu mẫu
    _loadDummyData();
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

    try {
      // Trong ứng dụng thực tế, gọi API để lấy chi tiết cuộc trò chuyện
      await Future.delayed(const Duration(seconds: 1)); // Mô phỏng delay mạng

      // Lọc tin nhắn theo chat ID
      // _messages =
      //     _messages
      //         .where(
      //           (msg) =>
      //               msg.senderId == _currentUserId &&
      //                   msg.receiverId == chatId ||
      //               msg.receiverId == _currentUserId && msg.senderId == chatId,
      //         )
      //         .toList();

      // _messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  void sendMessage(String content) {
    if (content.trim().isEmpty) return;

    // Trong ứng dụng thực tế, gọi API để gửi tin nhắn
    final newMessage = MessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderId: _currentUserId,
      receiverId: 'instructor_id', // ID người nhận (cần truyền vào từ UI)
      content: content,
      type: MessageType.text,
      createdAt: DateTime.now(),
    );

    _messages.add(newMessage);

    // Cập nhật lastMessage trong danh sách chat
    if (_chats.isNotEmpty) {
      final chatIndex = _chats.indexWhere(
        (chat) =>
            chat.participantIds.contains(newMessage.receiverId) &&
            chat.participantIds.contains(_currentUserId),
      );

      if (chatIndex != -1) {
        _chats[chatIndex] = _chats[chatIndex].copyWith(
          lastMessage: newMessage,
          unreadCount: 0,
        );
      }
    }

    notifyListeners();
  }

  void markAsRead(String messageId) {
    final index = _messages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      _messages[index] = _messages[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  // Tạo dữ liệu mẫu
  void _loadDummyData() {
    // Tạo một số tin nhắn mẫu
    final receiverId = 'instructor_id';

    _messages = [
      MessageModel(
        id: 'msg1',
        senderId: receiverId,
        receiverId: _currentUserId,
        content: 'Xin chào, tôi có thể giúp gì cho bạn?',
        type: MessageType.text,
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        isRead: true,
      ),
      MessageModel(
        id: 'msg2',
        senderId: _currentUserId,
        receiverId: receiverId,
        content: 'Tôi có một số thắc mắc về bài học hôm nay.',
        type: MessageType.text,
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
        isRead: true,
      ),
      MessageModel(
        id: 'msg3',
        senderId: receiverId,
        receiverId: _currentUserId,
        content: 'Vâng, bạn cứ nói đi, tôi sẽ giải đáp.',
        type: MessageType.text,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
      MessageModel(
        id: 'msg4',
        senderId: _currentUserId,
        receiverId: receiverId,
        content: 'Tôi không hiểu phần Redux Saga trong bài học.',
        type: MessageType.text,
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        isRead: true,
      ),
      MessageModel(
        id: 'msg5',
        senderId: receiverId,
        receiverId: _currentUserId,
        content:
            'Redux Saga là một middleware cho Redux để xử lý các side effects. Nó sử dụng generator function để tạo ra các saga, giúp quản lý các tác vụ bất đồng bộ dễ dàng hơn.',
        type: MessageType.text,
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        isRead: false,
      ),
    ];

    // Tạo danh sách chat
    _chats = [
      ChatModel(
        id: 'chat1',
        name: 'Giảng viên Hydra Coder',
        avatarUrl: 'assets/images/avatar.png',
        participantIds: [_currentUserId, receiverId],
        lastMessage: _messages.last,
        unreadCount: 1,
        isOnline: true,
        lastActive: DateTime.now(),
      ),
      ChatModel(
        id: 'chat2',
        name: 'Flutter Study Group',
        avatarUrl: 'assets/images/group_avatar.png',
        participantIds: [_currentUserId, 'user1', 'user2', 'user3'],
        lastMessage: MessageModel(
          id: 'msg_group',
          senderId: 'user1',
          receiverId: 'group_chat2',
          content: 'Mọi người đã hoàn thành bài tập chưa?',
          type: MessageType.text,
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        ),
        unreadCount: 5,
        isOnline: false,
        lastActive: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ];
  }
}
