import 'package:chat_app/core/socket_service.dart';
import 'package:chat_app/core/theme.dart';
import 'package:chat_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:chat_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:chat_app/features/auth/domain/usecases/register_use_case.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/pages/login_page.dart';
import 'package:chat_app/features/auth/presentation/pages/register_page.dart';
import 'package:chat_app/features/chat/data/datasource/messages_remote_data_source.dart';
import 'package:chat_app/features/chat/data/repositories/messages_repository_impl.dart';
import 'package:chat_app/features/chat/domain/usecases/fetch_messages_usecase.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/contacts/data/datasource/contacts_remote_data_source.dart';
import 'package:chat_app/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:chat_app/features/contacts/domain/usecases/add_contacts_usecase.dart';
import 'package:chat_app/features/contacts/domain/usecases/fetch_contacts_usecase.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:chat_app/features/conversation/data/datasource/conversation_remote_data_source.dart';
import 'package:chat_app/features/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:chat_app/features/conversation/domain/usecases/check_or_create_conversations_use_case.dart';
import 'package:chat_app/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:chat_app/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:chat_app/features/conversation/presentation/pages/conversations_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final socketService = SocketService();
  await socketService.initSocket();

  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource: AuthRemoteDataSource(),
  );

  final conversationRepository = ConversationRepositoryImpl(
    conversationRemoteDataSource: ConversationRemoteDataSource(),
  );

  final messagesRepository = MessagesRepositoryImpl(
    messagesRemoteDataSource: MessagesRemoteDataSource(),
  );

  final contactsRepository = ContactsRepositoryImpl(
    contactsRemoteDataSource: ContactsRemoteDataSource(),
  );

  runApp(
    MyApp(
      authRepository: authRepository,
      conversationRepository: conversationRepository,
      messagesRepository: messagesRepository,
      contactsRepository: contactsRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ConversationRepositoryImpl conversationRepository;
  final MessagesRepositoryImpl messagesRepository;
  final ContactsRepositoryImpl contactsRepository;

  const MyApp({super.key,
    required this.authRepository,
    required this.conversationRepository,
    required this.messagesRepository,
    required this.contactsRepository,
    });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            registerUseCase: RegisterUseCase(repository: authRepository),
            loginUseCase: LoginUseCase(repository: authRepository),
          ),
        ),
        BlocProvider(
          create: (_) => ConversationsBloc(
            fetchConversationsUseCase: FetchConversationsUseCase(repository: conversationRepository),
          ),
        ),
        BlocProvider(
          create: (_) => ChatBloc(
            fetchMessagesUseCase: FetchMessagesUsecase(messagesRepository: messagesRepository),
            ),
        ),
        BlocProvider(
          create: (_) => ContactsBloc(
            fetchContactsUseCase: FetchContactsUsecase(contactsRepository: contactsRepository),
            addContactsUseCase: AddContactsUsecase(contactsRepository: contactsRepository),
            checkOrCreateConversationsUseCase: CheckOrCreateConversationsUseCase(conversationRepository: conversationRepository),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/conversationPage': (_) => const ConversationsPage(),
        },
      ),
    );
  }
}

