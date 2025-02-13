import 'package:chat_app/features/conversation/data/datasource/conversation_remote_data_source.dart';
import 'package:chat_app/features/conversation/domain/entities/conversation_entity.dart';
import 'package:chat_app/features/conversation/domain/repositories/conversation_repository.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource conversationRemoteDataSource;

  ConversationRepositoryImpl({required this.conversationRemoteDataSource});

  @override
  Future<List<ConversationEntity>> fetchConversations() async {
    return await conversationRemoteDataSource.fetchConversations();
  }

}