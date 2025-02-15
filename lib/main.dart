import 'package:chat_app/core/socket_service.dart';
import 'package:chat_app/core/theme.dart';
import 'package:chat_app/di_container.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/pages/login_page.dart';
import 'package:chat_app/features/auth/presentation/pages/register_page.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:chat_app/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:chat_app/features/conversation/presentation/pages/conversations_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final socketService = SocketService();
  await socketService.initSocket();

  // Setting up getId
  setupDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            registerUseCase: sl(),
            loginUseCase: sl(),
          ),
        ),
        BlocProvider(
          create: (_) => ConversationsBloc(
            fetchConversationsUseCase: sl()
          ),
        ),
        BlocProvider(
          create: (_) => ChatBloc(
            fetchMessagesUseCase: sl(),
            fetchDailyQuestionUseCase: sl(),
            ),
        ),
        BlocProvider(
          create: (_) => ContactsBloc(
            fetchContactsUseCase: sl(),
            addContactsUseCase: sl(),
            checkOrCreateConversationsUseCase: sl(),
            fetchRecentContactsUsecase: sl(),
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

