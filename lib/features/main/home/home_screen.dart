import 'dart:math';

import 'package:finance_app/app/global_navigator/global_navigator.dart';
import 'package:finance_app/core/data/news_data.dart';
import 'package:finance_app/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance_app/core/extensions/padding_extension_on_widget.dart';
import 'package:finance_app/data/helpers/hive_helper.dart';
import 'package:finance_app/features/main/home/add_transaction/add_transaction_screen.dart';
import 'package:finance_app/features/main/home/components/history_item.dart';
import 'package:finance_app/features/main/home/components/news_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    int total = HiveHelper.allIncomesAmount + HiveHelper.allExpensesAmount;
    double expenseProgressValue =
        total == 0 ? .5 : min(1, HiveHelper.allExpensesAmount / total);
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 21,
        vertical: 23,
      ),
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: ShapeDecoration(
            color: const Color(0xFF2289E9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 132,
                    height: 132,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: const ShapeDecoration(
                              shape: OvalBorder(
                                side: BorderSide(
                                    width: 19.80, color: Color(0xFF3BFF93)),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          left: 10,
                          top: 10,
                          right: 10,
                          bottom: 10,
                          child: CircularProgressIndicator(
                            value: expenseProgressValue,
                            color: const Color(0xffF96F25),
                            strokeWidth: 20,
                          ),
                        ),
                        Text(
                          '${(expenseProgressValue * 100).toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(right: 15),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total \$$total',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ).paddingOnly(bottom: 18),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const ShapeDecoration(
                              color: Color(0xFF3BFF93),
                              shape: OvalBorder(),
                            ),
                          ).paddingOnly(right: 8),
                          Text(
                            'Income \$${HiveHelper.allIncomesAmount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ).expanded(),
                        ],
                      ).paddingOnly(bottom: 13),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFF96F25),
                              shape: OvalBorder(),
                            ),
                          ).paddingOnly(right: 8),
                          Text(
                            'Expense \$${HiveHelper.allExpensesAmount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ).expanded(),
                        ],
                      ),
                    ],
                  ).expanded(),
                ],
              ).paddingOnly(bottom: 18),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = 0;
                      });
                    },
                    child: Container(
                      height: 45,
                      decoration: ShapeDecoration(
                        color: currentTab == 0
                            ? Colors.white
                            : const Color(0xFF0966BD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'News',
                        style: TextStyle(
                          color: currentTab != 0
                              ? Colors.white
                              : const Color(0xFF0966BD),
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ).expanded(),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                    child: Container(
                      height: 45,
                      decoration: ShapeDecoration(
                        color: currentTab == 1
                            ? Colors.white
                            : const Color(0xFF0966BD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'History',
                        style: TextStyle(
                          color: currentTab != 1
                              ? Colors.white
                              : const Color(0xFF0966BD),
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ).expanded(),
                ],
              ).paddingOnly(bottom: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      GlobalNavigator.push(context,
                          page: const AddTransactionScreen(isIncome: true));
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF0966BD),
                        shape: OvalBorder(),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      GlobalNavigator.push(context,
                          page: const AddTransactionScreen(isIncome: false));
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF0966BD),
                        shape: OvalBorder(),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'EX',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ).paddingSymetric(horizontal: 50),
            ],
          ),
        ).paddingOnly(bottom: 24),
        if (currentTab == 0)
          ...List.generate(
            news.length,
            (index) {
              return NewsItem(item: news[index]).paddingOnly(bottom: 24);
            },
          )
        else
          ...List.generate(
            HiveHelper.transactions.length,
            (index) {
              return HistoryItem(transaction: HiveHelper.transactions.reversed.toList()[index])
                  .paddingOnly(bottom: 20);
            },
          )
      ],
    );
  }
}
