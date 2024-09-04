import 'package:finance_app/data/models/categories.dart';

const incomeCategories = [
  Business(),
  Salary(),
  Dividents(),
  InvestmentIncome(),
  Rent(),
  Freelance(),
  Royalty(),
  Passive(),
];

const expenseCategories = [
  Procurement(),
  Food(),
  Transport(),
  Restaurant(),
  InvestmentExpense(),
];


const allCategories = [...incomeCategories,...expenseCategories];