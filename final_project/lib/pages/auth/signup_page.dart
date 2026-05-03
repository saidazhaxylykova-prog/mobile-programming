import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../../blocs/auth/auth_cubit.dart';
import '../../blocs/auth/auth_state.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/gradient_button.dart';
import '../../core/widgets/saida_logo.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();

  @override
  void dispose() {
    _emailCtl.dispose();
    _passCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(color: AppColors.textDark),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.lavender, AppColors.pinkSoft],
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
                  t.signupTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  t.signupSubtitle,
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
                      (a.error != b.error && b.error != null) ||
                      (a.authenticated == false && b.authenticated == true),
                  listener: (context, state) {
                    if (state.authenticated) {
                      Navigator.of(context).popUntil((r) => r.isFirst);
                      return;
                    }
                    if (state.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error ?? t.errorGeneric),
                          backgroundColor: AppColors.pinkDeep,
                        ),
                      );
                      context.read<AuthCubit>().clearError();
                    }
                  },
                  builder: (context, state) {
                    return GradientButton(
                      label: t.signupButton,
                      loading: state.loading,
                      onPressed: () {
                        context
                            .read<AuthCubit>()
                            .signUp(_emailCtl.text, _passCtl.text);
                      },
                    );
                  },
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(t.haveAccount,
                        style: const TextStyle(color: AppColors.textDark)),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        t.loginButton,
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
