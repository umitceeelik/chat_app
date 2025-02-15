import "package:chat_app/features/chat/domain/entities/message_entity.dart";
import "package:chat_app/features/chat/domain/repositories/messages_repository.dart";

class FetchMessagesUseCase {
  final MessagesRepository repository;

  FetchMessagesUseCase({required this.repository});

  Future<List<MessageEntity>> call(String conversationId) async {
    return repository.fetchMessages(conversationId);
  }
}