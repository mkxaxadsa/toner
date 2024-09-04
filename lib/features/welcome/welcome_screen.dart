import 'package:finance_app/app/global_navigator/global_navigator.dart';
import 'package:finance_app/core/constants/app_images.dart';
import 'package:finance_app/core/extensions/align_ext_on_widget.dart';
import 'package:finance_app/core/extensions/padding_extension_on_widget.dart';
import 'package:finance_app/data/helpers/hive_helper.dart';
import 'package:finance_app/features/main/main_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Colors.white, Color(0xFF2289EA)],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    const Text(
                      'Personal financial consultant',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'All the necessary financial tools are collected in one convenient app.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      AppImages.welcomeImage,
                      width: double.maxFinite,
                    ).paddingSymetric(horizontal: 20),
                    const Spacer(),
                    const Text(
                      'Control your income and expenses, plan your budget',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        HiveHelper.setIsNotFirstTimeOpen().then((_) {
                          GlobalNavigator.pushAndRemoveUntil(context, page: const MainScreen());
                        });
                      },
                      child: Container(
                        width: 146,
                        height: 45,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'GO',
                          style: TextStyle(
                            color: Color(0xFF0966BD),
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ).align(),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ).paddingSymetric(horizontal: 44),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
