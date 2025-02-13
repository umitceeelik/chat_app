import "package:chat_app/features/chat/domain/entities/message_entity.dart";
import "package:chat_app/features/chat/domain/repositories/messages_repository.dart";

class FetchMessagesUsecase {
  final MessagesRepository messagesRepository;

  FetchMessagesUsecase({required this.messagesRepository});

  Future<List<MessageEntity>> call(String conversationId) async {
    return messagesRepository.fetchMessages(conversationId);
  }
}