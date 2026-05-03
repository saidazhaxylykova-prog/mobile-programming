import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_cubit.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/post/post_cubit.dart';
import 'auth/login_page.dart';
import 'home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (a, b) => a.authenticated != b.authenticated,
      listener: (context, state) {
        if (state.authenticated) {
          context.read<PostCubit>().watchFeed();
        }
      },
      builder: (context, state) {
        if (state.authenticated) {
          return const HomePage();
        }
        return const LoginPage();
      },
    );
  }
}
