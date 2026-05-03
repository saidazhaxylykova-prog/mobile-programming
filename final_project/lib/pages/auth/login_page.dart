import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../../blocs/auth/auth_cubit.dart';
import '../../blocs/auth/auth_state.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/gradient_button.dart';
import '../../core/widgets/saida_logo.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();

  @override
  void dispose() {
    _emailCtl.dispose();
    _passCtl.dispose();
    super.dispose();
  }

  void _goSignup() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, __, ___) => const SignupPage(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.pinkSoft, AppColors.lavender],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                const Center(child: SaidaLogo(fontSize: 44)),
                const SizedBox(height: 12),
                Text(
                  t.loginTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  t.loginSubtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textDark),
                ),
                const SizedBox(height: 28),
                AppTextField(
                  controller: _emailCtl,
                  hint: t.emailHint,
                  icon: Icons.alternate_email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _passCtl,
                  hint: t.passwordHint,
                  icon: Icons.lock_outline,
                  obscure: true,
                ),
                const SizedBox(height: 22),
                BlocConsumer<AuthCubit, AuthState>(
                  listenWhen: (a, b) =>
                      a.error != b.error && b.error != null,
                  listener: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error ?? t.errorGeneric),
                        backgroundColor: AppColors.pinkDeep,
                      ),
                    );
                    context.read<AuthCubit>().clearError();
                  },
                  builder: (context, state) {
                    return GradientButton(
                      label: t.loginButton,
                      loading: state.loading,
                      onPressed: () {
                        context
                            .read<AuthCubit>()
                            .login(_emailCtl.text, _passCtl.text);
                      },
                    );
                  },
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(t.noAccount,
                        style: const TextStyle(color: AppColors.textDark)),
                    TextButton(
                      onPressed: _goSignup,
                      child: Text(
                        t.signupButton,
                        style: const TextStyle(
                          color: AppColors.pinkDeep,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
