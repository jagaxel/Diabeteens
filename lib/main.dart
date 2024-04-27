import 'package:flutter/material.dart';
import 'package:snake_game/start_page.dart';
import 'package:snake_game/game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const StartPage(),
    );
  }
}