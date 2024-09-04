// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finance_app/app/global_navigator/global_navigator.dart';
import 'package:finance_app/core/constants/app_icons.dart';
import 'package:finance_app/core/data/categories.dart';
import 'package:finance_app/core/extensions/align_ext_on_widget.dart';
import 'package:finance_app/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance_app/core/extensions/hidekeyboard_ext_on_context.dart';
import 'package:finance_app/core/extensions/padding_extension_on_widget.dart';
import 'package:finance_app/data/helpers/hive_helper.dart';
import 'package:finance_app/data/models/expense_transaction.dart';
import 'package:finance_app/data/models/income_transaction.dart';
import 'package:finance_app/data/models/transaction.dart';
import 'package:finance_app/features/main/main_screen.dart';
import 'package:flutter/material.dart';

import 'package:finance_app/data/models/category.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({
    Key? key,
    required this.isIncome,
  }) : super(key: key);
  final bool isIncome;
  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  String title = "";
  int amount = 0;
  TransactionCategory? category;

  @override
  Widget build(BuildContext context) {
    bool isDone = title.isNotEmpty && amount > 0 && category != null;
    return GestureDetector(
      onTap: () {
        context.hideKeyboard();
      },
      child: Scaffold(
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
                      colors: [
                        Colors.white,
                        Color(0xFF2289EA),
                        Color(0xFF2289EA),
                        Color(0xFF2289EA)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 21,
                          ),
                          Text(
                            'Add ${widget.isIncome ? "Income" : "Expense"}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ).align().expanded(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              AppIcons.close,
                              width: 21,
                            ),
                          )
                        ],
                      )
                          .paddingOnly(top: 14, bottom: 7)
                          .paddingSymetric(horizontal: 18),
                      ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        children: [
                          const Text(
                            'Title',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ).paddingOnly(bottom: 5),
                          TextField(
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              title = value.trim();
                              setState(() {});
                            },
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xFF0966BD),
                              hintText: "Name title",
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ).paddingOnly(bottom: 5),
                          const Text(
                            'Amount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ).paddingOnly(bottom: 5),
                          TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              final res = int.tryParse(value.trim());
                              amount = res ?? amount;
                              setState(() {});
                            },
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xFF0966BD),
                              hintText: "Amount Income",
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ).paddingOnly(bottom: 65),
                          const Text(
                            'Category',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ).paddingOnly(bottom: 5),
                          Builder(
                            builder: (context) {
                              final list = widget.isIncome
                                  ? incomeCategories
                                  : expenseCategories;
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  list.length,
                                  (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          category = list[index];
                                        });
                                      },
                                      child: Container(
                                        width: double.maxFinite,
                                        height: 60,
                                        decoration: ShapeDecoration(
                                          color: category == list[index]
                                              ? Colors.white
                                              : const Color(0xFF0966BD),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          list[index].viewText,
                                          style: TextStyle(
                                            color: category != list[index]
                                                ? Colors.white
                                                : const Color(0xFF0966BD),
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ).paddingOnly(bottom: 20);
                                  },
                                ),
                              );
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              late final TransactionModel transaction;
                              if (widget.isIncome) {
                                transaction = IncomeTransactionModel(
                                    title: title,
                                    amount: amount,
                                    category: category!,
                                    dateTime: DateTime.now());
                              } else {
                                transaction = ExpenseTransactionModel(
                                    title: title,
                                    amount: amount,
                                    category: category!,
                                    dateTime: DateTime.now());
                              }
                              HiveHelper.addTransaction(transaction)
                                  .then((value) {
                                GlobalNavigator.pushAndRemoveUntil(context,
                                    page: const MainScreen());
                              });
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: ShapeDecoration(
                                color: isDone
                                    ? Colors.white
                                    : const Color(0xFF0966BD),
                                shape: const OvalBorder(),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: !isDone
                                      ? Colors.white
                                      : const Color(0xFF0966BD),
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ).align(),
                        ],
                      ).expanded(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
