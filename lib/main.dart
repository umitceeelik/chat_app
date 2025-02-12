import 'package:chat_app/chat_page.dart';
import 'package:chat_app/core/theme.dart';
import 'package:chat_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:chat_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:chat_app/features/auth/domain/usecases/register_use_case.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/pages/login_page.dart';
import 'package:chat_app/message_page.dart';
import 'package:chat_app/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final AuthRepositoryImpl repository = AuthRepositoryImpl(
    authRemoteDataSource: AuthRemoteDataSource(),
  );

  runApp(MyApp(authRepository: repository));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;

  const MyApp({super.key, required this.authRepository});

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: const Center(
            child: RegisterPage(),
          ),
        ),
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/chatPage': (_) => const ChatPage(),
          // '/message': (_) => const MessagePage(),
        },
      ),
    );
  }
}

