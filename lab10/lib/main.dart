import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api/rest_client.dart';
import 'blocs/profile/profile_bloc.dart';
import 'pages/profile_page.dart';

void main() {
  final dio = Dio();
  final restClient = RestClient(dio);

  runApp(MyApp(restClient: restClient));
}

class MyApp extends StatelessWidget {
  final RestClient restClient;

  const MyApp({super.key, required this.restClient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BlocProvider(
        create: (context) => ProfileBloc(restClient),
        child: const ProfilePage(),
      ),
    );
  }
}
