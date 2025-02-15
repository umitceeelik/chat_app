import 'package:chat_app/features/contacts/domain/repositories/contacts_repository.dart';

class AddContactsUseCase {
  final ContactsRepository repository;

  AddContactsUseCase({required this.repository});

  Future<void> call({required String email}) async{
    return await repository.addContact(email: email);
  }
}