// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finance_app/data/models/category.dart';

abstract class TransactionModel {
  final String title;
  final int amount;
  final DateTime dateTime;
  final TransactionCategory category;

  String get typeViewText;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.category,
  });

  TransactionModel copyWith({
    String? title,
    int? amount,
    DateTime? dateTime,
    TransactionCategory? category,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "amount": amount,
      "category_name": category.name,
      "date_time": dateTime.millisecondsSinceEpoch,
    };
  }
}
