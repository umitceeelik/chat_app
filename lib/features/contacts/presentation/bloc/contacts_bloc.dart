import 'package:chat_app/features/contacts/domain/usecases/add_contacts_usecase.dart';
import 'package:chat_app/features/contacts/domain/usecases/fetch_contacts_usecase.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:chat_app/features/conversation/domain/usecases/check_or_create_conversations_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState>{
  final FetchContactsUsecase fetchContactsUseCase;
  final AddContactsUsecase addContactsUseCase;
  final CheckOrCreateConversationsUseCase checkOrCreateConversationsUseCase;
  
  ContactsBloc({
    required this.addContactsUseCase,
    required this.fetchContactsUseCase,
    required this.checkOrCreateConversationsUseCase,
  }) : 
  super(ContactsInitial()) {
    on<FetchContacts>(_onFetchContacts);
    on<AddContact>(_onAddContact);
    on<CheckOrCreateConversation>(_onCheckOrCreateConversation);
  }


  Future<void> _onFetchContacts(FetchContacts event, Emitter<ContactsState> emit) async {
    emit(ContactsLoading());
    try {
      final contacts = await fetchContactsUseCase.call();
      emit(ContactsLoaded(contacts: contacts));
    } catch (error) {
      emit(ContactsError(message: "Failed to fetch contacts"));
    }
  }

  Future<void> _onAddContact(AddContact event, Emitter<ContactsState> emit) async {
    emit(ContactsLoading());
    try {
      await addContactsUseCase.call(email: event.email);
      emit(ContactAdded());
      add(FetchContacts());
    } catch (error) {
      emit(ContactsError(message: "Failed to add contact"));
    }
  }

  Future<void> _onCheckOrCreateConversation(CheckOrCreateConversation event, Emitter<ContactsState> emit) async {
    emit(ContactsLoading());
    try {
      final conversationId = await checkOrCreateConversationsUseCase.call(contactId: event.contactId);
      emit(ConversationReady(conversationId: conversationId, contactName: event.contactName));
    } catch (error) {
      emit(ContactsError(message: "Failed to start conversation"));
    }
  }
}