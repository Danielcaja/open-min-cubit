import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

import 'application/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: Asuka.builder,
      navigatorObservers: [
        Asuka
            .asukaHeroController //This line is needed for the Hero widget to work
      ],
      home: const HomePage(),
    );
  }
}
