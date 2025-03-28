import 'package:ecourse_flutter_v2/app/data/models/conversation_model.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/conversation_repository_impl.dart';
import 'package:ecourse_flutter_v2/app/domain/repositories/conversation_repository.dart';
import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/enums/conversation_type.enum.dart';

class ConversationVM extends BaseVM {
  final ConversationRepository _conversationRepository =
      ConversationRepositoryImpl();

  ConversationVM(super.context);

  final List<ConversationModel> _conversations = [];
  final List<ConversationModel> _groupConversations = [];

  List<ConversationModel> get conversations => _conversations;
  List<ConversationModel> get groupConversations => _groupConversations;

  @override
  void onInit() {
    super.onInit();
    getConversations();
  }

  Future<void> getConversations() async {
    _conversations.clear();
    _groupConversations.clear();
    final response = await _conversationRepository.getConversations();
    if (response.allGood) {
      for (var conversation in response.body) {
        final conversationModel = ConversationModel.fromJson(conversation);
        if (conversationModel.type == ConversationType.direct) {
          _conversations.add(conversationModel);
        } else {
          _groupConversations.add(conversationModel);
        }
      }
    }
  }
}
