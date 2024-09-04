import 'package:finance_app/core/extensions/format_ext_on_datetime.dart';
import 'package:finance_app/data/models/expense_transaction.dart';
import 'package:finance_app/data/models/income_transaction.dart';
import 'package:finance_app/data/models/transaction.dart';
import 'package:finance_app/data/parsers/transaction_parser.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox("APP_BOX");
  }

  static late final Box _box;

  static List<TransactionModel> get transactions {
    final resp = List.from(_box.get("transactions") ?? [])
        .map((e) => Map<String, dynamic>.from(Map.from(e)))
        .toList();
    final result = resp.map((e) => TransactionParser.parse(e)).toList();
    return result;
  }

  static List<IncomeTransactionModel> get allIncomes =>
      transactions.whereType<IncomeTransactionModel>().toList();

  static int get allIncomesAmount => allIncomes.isEmpty ? 0 : allIncomes
      .map((e) => e.amount)
      .reduce((value, element) => value + element);

  static List<ExpenseTransactionModel> get allExpenses =>
      transactions.whereType<ExpenseTransactionModel>().toList();

  static int get allExpensesAmount => allExpenses.isEmpty ? 0 :  allExpenses
      .map((e) => e.amount)
      .reduce((value, element) => value + element);

  static List<List<IncomeTransactionModel>> get todayIncoms {
    final now = DateTime.now().ymd;
    final filtered = allIncomes
        .where((element) => element.dateTime.ymd.difference(now).inDays == 0)
        .toList();
    return [filtered];
  }

  static List<List<ExpenseTransactionModel>> get todayExpenses {
    final now = DateTime.now().ymd;
    final filtered = allExpenses
        .where((element) => element.dateTime.ymd.difference(now).inDays == 0)
        .toList();
    return [filtered];
  }

  static List<List<IncomeTransactionModel>> get lastWeekIncomes {
    if (allIncomes.isEmpty) return [];
    final res = _incomesSplitedByDays.reversed
        .toList()
        .sublist(0, _incomesSplitedByDays.length >= 7 ? 7 : null);
    return res;
  }

  static List<List<ExpenseTransactionModel>> get lastWeekExpenses {
    if (allExpenses.isEmpty) return [];
    final res = _expensesSplitedByDays.reversed
        .toList()
        .sublist(0, _expensesSplitedByDays.length >= 7 ? 7 : null);
    return res;
  }

  static List<List<IncomeTransactionModel>> get lastMonthIncomes {
    if (allIncomes.isEmpty) return [];
    final res = _incomesSplitedByDays.reversed
        .toList()
        .sublist(0, _incomesSplitedByDays.length >= 28 ? 28 : null);
    return res;
  }

  static List<List<ExpenseTransactionModel>> get lastMonthExpenses {
    if (allExpenses.isEmpty) return [];
    List<List<ExpenseTransactionModel>> res = _expensesSplitedByDays.reversed
        .toList()
        .sublist(0, _expensesSplitedByDays.length >= 28 ? 28 : null);
    List<List<ExpenseTransactionModel>> result = [];
    for (int i = 0; i < (res.length / 7).ceil(); i++) {
      result.add([
        res[i].reduce(
          (value, element) => value.copyWith(
            amount: value.amount + element.amount,
          ),
        ),
      ]);
    }

    return result;
  }

  static List<List<IncomeTransactionModel>> get _incomesSplitedByDays =>
      _splitListByDatetime<IncomeTransactionModel>(allIncomes);
  static List<List<ExpenseTransactionModel>> get _expensesSplitedByDays =>
      _splitListByDatetime<ExpenseTransactionModel>(allExpenses);

  static int get income {
    int res = 0;
    for (final tr in allIncomes) {
      res += tr.amount;
    }
    return res;
  }

  static int get expense {
    int res = 0;
    for (final tr in allExpenses) {
      res += tr.amount;
    }
    return res;
  }

  static int get balance {
    return income - expense;
  }

  static bool get isFirstTimeOpen {
    return _box.get("is_first_time_open") ?? true;
  }

  static Future<void> setIsNotFirstTimeOpen() async {
    await _box.put("is_first_time_open", false);
  }

  static Future<void> addTransaction(TransactionModel transaction) async {
    List<TransactionModel> tr = [...transactions, transaction];

    await _box.put("transactions", tr.map((e) => e.toMap()).toList());
  }
}

List<List<T>> _splitListByDatetime<T extends TransactionModel>(List<T> items) {
  if (items.isEmpty) return [];

  List<List<T>> groupedItems = [];
  List<T> currentGroup = [items[0]];

  for (int i = 1; i < items.length; i++) {
    if (_isSameDatetime(items[i].dateTime, items[i - 1].dateTime)) {
      currentGroup.add(items[i]);
    } else {
      groupedItems.add(currentGroup);
      currentGroup = [items[i]];
    }
  }

  // Add the last group
  groupedItems.add(currentGroup);

  return groupedItems;
}

bool _isSameDatetime(DateTime dt1, DateTime dt2) {
  return dt1.year == dt2.year && dt1.month == dt2.month && dt1.day == dt2.day;
}
