import 'package:chat_app/features/conversation/domain/repositories/conversation_repository.dart';

class CheckOrCreateConversationsUseCase {
  final ConversationRepository repository;

  CheckOrCreateConversationsUseCase({required this.repository});

  Future<String> call({required String contactId}) async {
    return await repository.checkOrCreateConversations(contactId: contactId);
  }
}