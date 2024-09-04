import 'package:finance_app/app/app.dart';
import 'package:finance_app/data/helpers/hive_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  runApp(const FinanceApp());
}