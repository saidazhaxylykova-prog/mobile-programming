import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Page')),
      body: Center(
        child: Text(
          'Welcome! Registration successful.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
