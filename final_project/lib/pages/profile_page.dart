import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../l10n/app_localizations.dart';
import '../blocs/auth/auth_cubit.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/post/post_cubit.dart';
import '../blocs/post/post_state.dart';
import '../blocs/settings/settings_cubit.dart';
import '../blocs/settings/settings_state.dart';
import '../core/constants/app_colors.dart';
import '../core/widgets/post_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _usernameCtl;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthCubit>().state;
    _usernameCtl = TextEditingController(text: auth.username ?? '');
  }

  @override
  void dispose() {
    _usernameCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.tabProfile)),
      body: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (a, b) => a.username != b.username,
        listener: (context, state) {
          _usernameCtl.text = state.username ?? '';
        },
        builder: (context, auth) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _Header(username: auth.username ?? '', email: auth.email ?? ''),
              const SizedBox(height: 18),
              _Section(
                title: t.profileUsername,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _usernameCtl,
                        enabled: _editing,
                        decoration: InputDecoration(hintText: t.profileUsername),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(_editing ? Icons.check : Icons.edit_outlined,
                          color: AppColors.pinkDeep),
                      onPressed: () async {
                        if (_editing) {
                          await context
                              .read<AuthCubit>()
                              .updateUsername(_usernameCtl.text);
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(t.usernameUpdated),
                              backgroundColor: AppColors.pinkDeep,
                            ),
                          );
                        }
                        setState(() => _editing = !_editing);
                      },
                    ),
                  ],
                ),
              ),
              _Section(
                title: t.language,
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, s) {
                    return DropdownButton<String>(
                      isExpanded: true,
                      value: s.locale.languageCode,
                      underline: const SizedBox.shrink(),
                      items: [
                        DropdownMenuItem(
                            value: 'en', child: Text(t.langEnglish)),
                        DropdownMenuItem(
                            value: 'ru', child: Text(t.langRussian)),
                        DropdownMenuItem(
                            value: 'kk', child: Text(t.langKazakh)),
                      ],
                      onChanged: (v) {
                        if (v == null) return;
                        context
                            .read<SettingsCubit>()
                            .setLocale(Locale(v));
                      },
                    );
                  },
                ),
              ),
              _Section(
                title: t.theme,
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, s) {
                    return SegmentedButton<ThemeMode>(
                      segments: [
                        ButtonSegment(
                            value: ThemeMode.system,
                            label: Text(t.themeSystem),
                            icon: const Icon(Icons.brightness_auto)),
                        ButtonSegment(
                            value: ThemeMode.light,
                            label: Text(t.themeLight),
                            icon: const Icon(Icons.light_mode)),
                        ButtonSegment(
                            value: ThemeMode.dark,
                            label: Text(t.themeDark),
                            icon: const Icon(Icons.dark_mode)),
                      ],
                      selected: {s.themeMode},
                      onSelectionChanged: (set) {
                        context.read<SettingsCubit>().setTheme(set.first);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.heart,
                    side: const BorderSide(color: AppColors.heart),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => context.read<AuthCubit>().logout(),
                  icon: const Icon(Icons.logout_rounded),
                  label: Text(t.logOut),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  t.myPosts,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<PostCubit, PostState>(
                builder: (context, ps) {
                  final mine = ps.posts
                      .where((p) => p.userId == auth.uid)
                      .toList();
                  if (mine.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: Text(t.feedEmpty)),
                    );
                  }
                  return Column(
                    children: [
                      for (var i = 0; i < mine.length; i++)
                        PostCard(
                          post: mine[i],
                          index: i,
                          likedByMe: auth.uid != null &&
                              mine[i].likedBy.contains(auth.uid),
                          onLike: () {
                            if (auth.uid == null) return;
                            context.read<PostCubit>().toggleLike(
                                  postId: mine[i].postId,
                                  uid: auth.uid!,
                                  currentlyLiked:
                                      mine[i].likedBy.contains(auth.uid),
                                );
                          },
                        ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String username;
  final String email;
  const _Header({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    final initial = username.isNotEmpty ? username[0].toUpperCase() : '?';
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.gradientSoft,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              gradient: AppColors.gradientPink,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(color: AppColors.textDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(title,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w700)),
          ),
          child,
        ],
      ),
    );
  }
}
