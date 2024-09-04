import 'package:finance_app/app/global_navigator/global_navigator.dart';
import 'package:finance_app/data/helpers/hive_helper.dart';
import 'package:finance_app/features/main/main_screen.dart';
import 'package:finance_app/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (HiveHelper.isFirstTimeOpen) {
          GlobalNavigator.pushAndRemoveUntil(context,
              page: const WelcomeScreen());
        } else {
          GlobalNavigator.pushAndRemoveUntil(context, page: const MainScreen());
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
