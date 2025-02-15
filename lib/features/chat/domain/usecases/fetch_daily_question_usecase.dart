import 'package:chat_app/features/chat/domain/entities/daily_question_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/messages_repository.dart';

class FetchDailyQuestionUseCase {
  final MessagesRepository repository;

  FetchDailyQuestionUseCase({required this.repository});

  Future<DailyQuestionEntity> call(String conversationId) async {
    return await repository.fetchDailyQuestion(conversationId);
  }
}