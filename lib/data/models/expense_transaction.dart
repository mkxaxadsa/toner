import 'package:finance_app/data/models/category.dart';
import 'package:finance_app/data/models/transaction.dart';
import 'package:finance_app/data/parsers/transaction_category_parser.dart';

class ExpenseTransactionModel extends TransactionModel {
  ExpenseTransactionModel({
    required super.title,
    required super.amount,
    required super.category,
    required super.dateTime,
  });

  static String get type => "Expense";

  @override
  String get typeViewText => type;

  @override
  Map<String, dynamic> toMap() {
    return {
      "type": type,
    }..addAll(super.toMap());
  }

  factory ExpenseTransactionModel.fromMap(Map<String, dynamic> map) {
    return ExpenseTransactionModel(
      title: map["title"],
      amount: map["amount"],
      category: TransactionCategoryParser.parse(map["category_name"]),
      dateTime: DateTime.fromMillisecondsSinceEpoch(map["date_time"]),
    );
  }

  @override
  ExpenseTransactionModel copyWith({
    String? title,
    int? amount,
    DateTime? dateTime,
    TransactionCategory? category,
  }) {
    return ExpenseTransactionModel(
      amount: amount ?? this.amount,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
      title: title ?? this.title,
    );
  }
}
