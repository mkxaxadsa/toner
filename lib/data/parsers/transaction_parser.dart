import 'package:finance_app/data/models/expense_transaction.dart';
import 'package:finance_app/data/models/income_transaction.dart';
import 'package:finance_app/data/models/transaction.dart';

class TransactionParser {
  static TransactionModel parse (Map<String,dynamic> map) {
    if(map["type"] == IncomeTransactionModel.type) return IncomeTransactionModel.fromMap(map);
    return ExpenseTransactionModel.fromMap(map);
  }
}