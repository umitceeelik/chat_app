import 'package:chat_app/features/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:chat_app/features/conversation/domain/repositories/conversation_repository.dart';

class CheckOrCreateConversationsUseCase {
  final ConversationRepository conversationRepository;

  CheckOrCreateConversationsUseCase({required this.conversationRepository});

  Future<String> call({required String contactId}) async {
    return await conversationRepository.checkOrCreateConversations(contactId: contactId);
  }
}