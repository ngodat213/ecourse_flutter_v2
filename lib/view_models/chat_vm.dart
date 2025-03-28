import 'package:ecourse_flutter_v2/app/data/repositories/conversation_repository_impl.dart';
import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/chat_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_profile.dart';
import 'package:ecourse_flutter_v2/app/domain/repositories/conversation_repository.dart';
import 'package:ecourse_flutter_v2/app/data/models/conversation_model.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:provider/provider.dart';

class ChatVM extends BaseVM {
  final ConversationRepository conversationRepository =
      ConversationRepositoryImpl();

  final List<ChatModel> _messages = [];
  final List<ConversationModel> _chats = [];
  UserProfile? _userData;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<ChatModel> get messages => _messages;
  List<ConversationModel> get chats => _chats;
  UserProfile? get currentUserId => _userData;
  @override
  bool get isLoading => _isLoading;
  @override
  String? get error => _error;

  ChatVM(super.context);

  @override
  void onInit() {
    super.onInit();
    _userData = context.read<UserVM>().userProfile;
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
    // if (content.trim().isEmpty) return;

    // // Trong ứng dụng thực tế, gọi API để gửi tin nhắn
    // final newMessage = ChatModel(
    //   id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
    //   senderId: _currentUserId,
    //   receiverId: 'instructor_id', // ID người nhận (cần truyền vào từ UI)
    //   content: content,
    //   type: MessageType.text,
    //   createdAt: DateTime.now(),
    // );

    // _messages.add(newMessage);

    // // Cập nhật lastMessage trong danh sách chat
    // if (_chats.isNotEmpty) {
    //   final chatIndex = _chats.indexWhere(
    //     (chat) =>
    //         chat.participants.contains(newMessage.receiverId) &&
    //         chat.participants.contains(_currentUserId),
    //   );

    //   if (chatIndex != -1) {
    //     _chats[chatIndex] = _chats[chatIndex].copyWith(
    //       lastMessage: newMessage,
    //       unreadCount: 0,
    //     );
    //   }
    // }

    notifyListeners();
  }

  // void markAsRead(String messageId) {
  //   final index = _messages.indexWhere((msg) => msg.id == messageId);
  //   if (index != -1) {
  //     _messages[index] = _messages[index].copyWith(isRead: true);
  //     notifyListeners();
  //   }
  // }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }
}
