
import 'package:chat_app/features/contacts/domain/entities/contact_entity.dart';
import 'package:chat_app/features/contacts/domain/repositories/contacts_repository.dart';

class FetchRecentContactsUseCase {
  final ContactsRepository repository;

  FetchRecentContactsUseCase({required this.repository});

  Future<List<ContactEntity>> call() async{
    return await repository.fetchRecentContacts();
  }
}