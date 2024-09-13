import 'package:finance_app/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance_app/features/main/activities/activities_screen.dart';
import 'package:finance_app/features/main/components/bottom_bar.dart';
import 'package:finance_app/features/main/home/home_screen.dart';
import 'package:finance_app/features/main/settings/settings_screen.dart';
import 'package:finance_app/features/quiz/QuizMainScreen.dart';
import 'package:finance_app/main.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    fmjdsknfkjds();
  }

  final pages = [
    const HomeScreen(),
    const ActivitiesScreen(),
    const QuizPage(),
    const SettingsScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              pages[currentIndex].expanded(),
              BottomBarWidget(
                currentPageIndex: currentIndex,
                onChanged: (pageIndex) {
                  setState(() {
                    currentIndex = pageIndex;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
