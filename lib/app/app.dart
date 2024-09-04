import 'package:finance_app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class FinanceApp extends StatefulWidget {
  const FinanceApp({super.key});

  @override
  State<FinanceApp> createState() => _FinanceAppState();
}

class _FinanceAppState extends State<FinanceApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData.light(useMaterial3: true).copyWith(scaffoldBackgroundColor: Colors.white),
    );
  }
}
