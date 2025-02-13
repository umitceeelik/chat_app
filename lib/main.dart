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
import 'package:chat_app/features/conversation/data/datasource/conversation_remote_data_source.dart';
import 'package:chat_app/features/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:chat_app/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:chat_app/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:chat_app/features/conversation/presentation/pages/conversations_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final AuthRepositoryImpl authRepository = AuthRepositoryImpl(
    authRemoteDataSource: AuthRemoteDataSource(),
  );

  final ConversationRepositoryImpl conversationRepository = ConversationRepositoryImpl(
    conversationRemoteDataSource: ConversationRemoteDataSource(),
  );

  final MessagesRepositoryImpl messagesRepository = MessagesRepositoryImpl(
    messagesRemoteDataSource: MessagesRemoteDataSource(),
  );

  runApp(
    MyApp(
      authRepository: authRepository,
      conversationRepository: conversationRepository,
      messagesRepository: messagesRepository
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ConversationRepositoryImpl conversationRepository;
  final MessagesRepositoryImpl messagesRepository;

  const MyApp({super.key,
    required this.authRepository,
    required this.conversationRepository,
    required this.messagesRepository,
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

