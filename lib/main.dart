import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  const String env = String.fromEnvironment('ENV', defaultValue: 'dev');
  await dotenv.load(fileName: 'assets/environments/.env.$env');
  runApp(const MainApp(env: env));
}

class MainApp extends StatelessWidget {
  final String env;
  const MainApp({super.key, required this.env});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estados do Brasil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(env: env),
    );
  }
}
