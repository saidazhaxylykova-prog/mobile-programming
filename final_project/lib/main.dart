import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'l10n/app_localizations.dart';

import 'api/rest_client.dart';
import 'blocs/api/api_cubit.dart';
import 'blocs/auth/auth_cubit.dart';
import 'blocs/post/post_cubit.dart';
import 'blocs/settings/settings_cubit.dart';
import 'blocs/settings/settings_state.dart';
import 'core/storage/preferences_service.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'pages/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await PreferencesService.create();
  final dio = Dio();
  final restClient = RestClient(dio);
  runApp(SaidaGramApp(prefs: prefs, restClient: restClient));
}

class SaidaGramApp extends StatelessWidget {
  final PreferencesService prefs;
  final RestClient restClient;

  const SaidaGramApp({
    super.key,
    required this.prefs,
    required this.restClient,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SettingsCubit(prefs)),
        BlocProvider(
          create: (_) => AuthCubit(
            FirebaseAuth.instance,
            FirebaseFirestore.instance,
            prefs,
          ),
        ),
        BlocProvider(create: (_) => PostCubit(FirebaseFirestore.instance)),
        BlocProvider(create: (_) => ApiCubit(restClient)),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settings) {
          return MaterialApp(
            title: 'SaidaGram',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: settings.themeMode,
            locale: settings.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const AuthGate(),
          );
        },
      ),
    );
  }
}
