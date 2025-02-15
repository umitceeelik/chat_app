import 'package:chat_app/features/contacts/domain/entities/contact_entity.dart';

abstract class ContactsEvent {}

class FetchContacts extends ContactsEvent {}

class AddContact extends ContactsEvent {
  final String email;

  AddContact({required this.email});
}

class CheckOrCreateConversation extends ContactsEvent {
  final String contactId;
  final ContactEntity contact;


  CheckOrCreateConversation({required this.contactId, required this.contact});
}

class LoadRecentContacts extends ContactsEvent {}