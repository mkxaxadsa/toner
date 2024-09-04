import 'package:finance_app/core/data/categories.dart';
import 'package:finance_app/data/models/category.dart';

class TransactionCategoryParser {
  static TransactionCategory parse(String name) {
    return allCategories.firstWhere((element) => element.name == name);
  }
}