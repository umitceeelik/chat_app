import 'package:chat_app/features/contacts/domain/repositories/contacts_repository.dart';

class AddContactsUsecase {
  final ContactsRepository contactsRepository;

  AddContactsUsecase({required this.contactsRepository});

  Future<void> call({required String email}) async{
    return await contactsRepository.addContact(email: email);
  }
}