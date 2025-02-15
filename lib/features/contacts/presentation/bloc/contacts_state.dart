import 'package:chat_app/features/contacts/domain/entities/contact_entity.dart';

abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<ContactEntity> contacts;
  
  ContactsLoaded({required this.contacts});
}

class ContactsError extends ContactsState {
  final String message;

  ContactsError({required this.message});
}

class ContactAdded extends ContactsState {}

class ConversationReady extends ContactsState {
  final String conversationId;
  final ContactEntity contact;

  ConversationReady({required this.conversationId, required this.contact});
}

class RecentContactsLoaded extends ContactsState {
  final List<ContactEntity> recentContacts;

  RecentContactsLoaded({required this.recentContacts});
}
