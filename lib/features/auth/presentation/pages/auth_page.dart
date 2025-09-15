import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sos/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:sos/features/auth/presentation/cubits/auth_states.dart';
import 'package:sos/features/auth/presentation/pages/login_page.dart';
import 'package:sos/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // login/register success → return Home
          Navigator.pop(context);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (showLoginPage) {
          return LoginPage(togglePages: togglePages);
        } else {
          return RegisterPage(togglePages: togglePages);
        }
      },
    );
  }
}
