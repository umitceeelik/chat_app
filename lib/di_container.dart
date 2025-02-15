import 'package:chat_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:chat_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:chat_app/features/auth/domain/usecases/register_use_case.dart';
import 'package:chat_app/features/chat/data/datasource/messages_remote_data_source.dart';
import 'package:chat_app/features/chat/data/repositories/messages_repository_impl.dart';
import 'package:chat_app/features/chat/domain/repositories/messages_repository.dart';
import 'package:chat_app/features/chat/domain/usecases/fetch_daily_question_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/fetch_messages_usecase.dart';
import 'package:chat_app/features/contacts/data/datasource/contacts_remote_data_source.dart';
import 'package:chat_app/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:chat_app/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:chat_app/features/contacts/domain/usecases/add_contacts_usecase.dart';
import 'package:chat_app/features/contacts/domain/usecases/fetch_contacts_usecase.dart';
import 'package:chat_app/features/contacts/domain/usecases/fetch_recent_contacts_usecase.dart';
import 'package:chat_app/features/conversation/data/datasource/conversation_remote_data_source.dart';
import 'package:chat_app/features/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:chat_app/features/conversation/domain/repositories/conversation_repository.dart';
import 'package:chat_app/features/conversation/domain/usecases/check_or_create_conversations_use_case.dart';
import 'package:chat_app/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setupDependencies() {

  const String baseUrl = 'http://10.0.2.2:6000';
  // const _storage = FlutterSecureStorage();

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<ConversationRemoteDataSource>(() => ConversationRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<MessagesRemoteDataSource>(() => MessagesRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<ContactsRemoteDataSource>(() => ContactsRemoteDataSource(baseUrl: baseUrl));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authRemoteDataSource: sl()));
  sl.registerLazySingleton<ConversationRepository>(() => ConversationRepositoryImpl(conversationRemoteDataSource: sl()));
  sl.registerLazySingleton<MessagesRepository>(() => MessagesRepositoryImpl(messagesRemoteDataSource: sl()));
  sl.registerLazySingleton<ContactsRepository>(() => ContactsRepositoryImpl(contactsRemoteDataSource: sl()));

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchConversationsUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchMessagesUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchDailyQuestionUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchContactsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddContactsUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckOrCreateConversationsUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchRecentContactsUseCase(repository: sl()));



  // Blocs
  // sl.registerFactory<AuthBloc>(() => AuthBloc(loginUseCase: sl(), registerUseCase: sl()));
  // sl.registerFactory<ConversationsBloc>(() => ConversationsBloc(fetchConversationsUseCase: sl(), checkOrCreateConversationsUseCase: sl()));
  // sl.registerFactory<ChatBloc>(() => ChatBloc(fetchMessagesUseCase: sl(), fetchDailyQuestionUseCase: sl()));
  // sl.registerFactory<ContactsBloc>(() => ContactsBloc(fetchContactsUseCase: sl(), addContactsUseCase: sl(), fetchRecentContactsUseCase: sl()));

}