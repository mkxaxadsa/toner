import 'package:finance_app/core/constants/app_icons.dart';
import 'package:finance_app/data/models/category.dart';

class Business extends TransactionCategory {
  const Business(): super(name: "Business");

  @override
  String get asset => AppIcons.business;
}

class Salary extends TransactionCategory {
  const Salary(): super(name: "Salary");

  @override
  String get asset => AppIcons.salary;
}

class Dividents extends TransactionCategory {
  const Dividents(): super(name: "Dividents");

  @override
  String get asset => AppIcons.dividents;
}

class InvestmentIncome extends TransactionCategory {
  const InvestmentIncome(): super(name: "Investment_Income");

  @override
  String get viewText => "Investment";

  @override
  String get asset => AppIcons.investment;
}


class Rent extends TransactionCategory {
  const Rent(): super(name: "Rent");

  @override
  String get asset => AppIcons.rent;
}

class Freelance extends TransactionCategory {
  const Freelance(): super(name: "Freelance");

  @override
  String get asset => AppIcons.freelance;
}

class Royalty extends TransactionCategory {
  const Royalty(): super(name: "Royalty");

  @override
  String get asset => AppIcons.royality;
}

class Passive extends TransactionCategory {
  const Passive(): super(name: "Passive");

  @override
  String get asset => AppIcons.passive;
}

class Procurement extends TransactionCategory {
  const Procurement(): super(name: "Procurement");

  @override
  String get asset => AppIcons.procurement;
}

class Food extends TransactionCategory {
  const Food(): super(name: "Food");

  @override
  String get asset => AppIcons.food;
}

class Transport extends TransactionCategory {
  const Transport(): super(name: "Transport");

  @override
  String get asset => AppIcons.food;
}

class Restaurant extends TransactionCategory {
  const Restaurant(): super(name: "Restaurant");

  @override
  String get asset => AppIcons.rest;
}

class InvestmentExpense extends TransactionCategory {
  const InvestmentExpense(): super(name: "Investment_Expense");

  @override
  String get viewText => "Investment";

  @override
  String get asset => AppIcons.investment2;
}
