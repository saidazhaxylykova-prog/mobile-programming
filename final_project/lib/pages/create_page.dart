import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../l10n/app_localizations.dart';
import '../blocs/auth/auth_cubit.dart';
import '../blocs/post/post_cubit.dart';
import '../blocs/post/post_state.dart';
import '../core/constants/app_colors.dart';
import '../core/widgets/gradient_button.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _ctl = TextEditingController();

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.tabCreate)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  gradient: AppColors.gradientSoft,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    color: Theme.of(context).cardTheme.color,
                    child: TextField(
                      controller: _ctl,
                      maxLines: 8,
                      maxLength: 280,
                      decoration: InputDecoration(
                        hintText: t.createPlaceholder,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<PostCubit, PostState>(
                listenWhen: (a, b) =>
                    a.creating == true && b.creating == false && b.error == null,
                listener: (context, state) {
                  _ctl.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(t.postCreated),
                      backgroundColor: AppColors.pinkDeep,
                    ),
                  );
                },
                builder: (context, state) {
                  return GradientButton(
                    label: t.post,
                    icon: Icons.send_rounded,
                    loading: state.creating,
                    onPressed: () {
                      final auth = context.read<AuthCubit>().state;
                      if (auth.uid == null) return;
                      context.read<PostCubit>().createPost(
                            userId: auth.uid!,
                            username: auth.username ?? 'user',
                            content: _ctl.text,
                          );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
