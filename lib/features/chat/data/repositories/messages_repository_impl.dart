import 'package:chat_app/features/chat/data/datasource/messages_remote_data_source.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/messages_repository.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesRemoteDataSource messagesRemoteDataSource;

  MessagesRepositoryImpl({required this.messagesRemoteDataSource});

  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    return await messagesRemoteDataSource.fetchMessages(conversationId);
  }

  @override
  Future<void> sendMessage(MessageEntity message) async {
    // return await messagesRemoteDataSource.sendMessage(message);
    throw UnimplementedError();
  }
}
