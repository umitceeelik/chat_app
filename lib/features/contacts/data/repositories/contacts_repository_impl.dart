
import 'package:chat_app/features/contacts/data/datasource/contacts_remote_data_source.dart';
import 'package:chat_app/features/contacts/data/models/contacts_model.dart';
import 'package:chat_app/features/contacts/domain/repositories/contacts_repository.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsRemoteDataSource contactsRemoteDataSource;

  ContactsRepositoryImpl({required this.contactsRemoteDataSource});

  @override
  Future<void> addContact({required String email}) async {
    return await contactsRemoteDataSource.addContact(email: email);
  }

  @override
  Future<List<ContactsModel>> fetchContacts() async {
    return await contactsRemoteDataSource.fetchContacts();
  }
  
}