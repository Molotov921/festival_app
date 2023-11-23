import 'package:flutter/material.dart';
import 'package:festival_app/screens/design_quotes.dart';
import 'package:festival_app/screens/fest_design.dart';
import 'package:festival_app/screens/festival.dart';
import 'package:festival_app/screens/info_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'festival': (context) => const Festival(),
        '/': (context) => const InfoPage(),
        'design_quotes': (context) => const Design_Quotes(),
        'fest_design': (context) => const Fest_Design(),
      },
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData.light(useMaterial3: true),
      themeMode: ThemeMode.dark,
    );
  }
}
