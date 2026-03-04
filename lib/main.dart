// main.dart
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INITIALISATION DES LOCALES (OBLIGATOIRE)
  await initializeDateFormatting('fr', null);

  runApp(const MeteoCityApp());
}

class MeteoCityApp extends StatelessWidget {
  const MeteoCityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MeteoCity",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SplashPage(),
    );
  }
}
