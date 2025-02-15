import 'package:chat_app/features/contacts/domain/entities/contact_entity.dart';
import 'package:chat_app/features/conversation/domain/entities/conversation_entity.dart';

abstract class ConversationsState {}

class ConversationsInitial extends ConversationsState {}

class ConversationsLoading extends ConversationsState {}

class ConversationsLoaded extends ConversationsState {
  final List<ConversationEntity> conversations;
  
  ConversationsLoaded({required this.conversations});
}

class ConversationError extends ConversationsState {
  final String message;

  ConversationError({required this.message});
}

