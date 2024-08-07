import 'package:flutter/material.dart';

import '../widgets/news_page.dart';
import '../widgets/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToNewsPage();
  }

  _navigateToNewsPage() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 150, // 원하는 너비
                height: 150, // 원하는 높이
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // 이미지도 테두리에 맞춰 둥글게
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover, // 이미지가 컨테이너를 덮도록
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              const Text(
                'Loading...',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
