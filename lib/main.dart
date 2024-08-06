import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './widgets/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Economic News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          bodyLarge: TextStyle(color: Colors.black),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
