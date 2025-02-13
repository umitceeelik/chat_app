import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:chat_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:chat_app/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:chat_app/features/auth/presentation/widgets/auth_promt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        email: _emailController.text,
        password: _passwordController.text,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthInputField(hint: 'Email', icon: Icons.mail, controller: _emailController),
              SizedBox(height: 20),
              AuthInputField(hint: 'Password', icon: Icons.lock, controller: _passwordController, isPassword: true),
              SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return AuthButton(
                    text: 'Login',
                    onPressed: _onLogin,
                  );
                },
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    print('Login successful');
                    Navigator.pushNamedAndRemoveUntil(context, '/conversationPage', (route) => false);
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error))
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              AuthPromt(textGrey: 'Don\'t have an account? ', textBlue: 'Click here to register', onTap: () {Navigator.pushNamed(context, '/register');}),
            ],
          ), 
        ),
      ),
    );
  }
}