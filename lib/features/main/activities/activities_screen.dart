import 'package:finance_app/core/constants/weekdays.dart';
import 'package:finance_app/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance_app/core/extensions/format_ext_on_datetime.dart';
import 'package:finance_app/core/extensions/padding_extension_on_widget.dart';
import 'package:finance_app/core/ui_components/action_button.dart';
import 'package:finance_app/data/helpers/hive_helper.dart';
import 'package:finance_app/data/models/expense_transaction.dart';
import 'package:finance_app/data/models/income_transaction.dart';
import 'package:finance_app/features/main/activities/components/diagram_widget.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  int currentRangeIndex = 0;

  final dayLabels = [weekdays[DateTime.now().weekday - 1]];

  List<String> weekLabels = [];

  List<String> monthLabels = [];

  late final List<Map<String, dynamic>> dayValues;

  late final List<Map<String, dynamic>> weekValues;

  late final List<Map<String, dynamic>> monthValues;

  int dayIncome = 0;
  int dayExpense = 0;

  int weekIncome = 0;
  int weekExpense = 0;

  int monthIncome = 0;
  int monthExpense = 0;

  @override
  void initState() {
    dayValues = getValueData(HiveHelper.todayIncoms, HiveHelper.todayExpenses);
    weekValues =
        getValueData(HiveHelper.lastWeekIncomes, HiveHelper.lastWeekExpenses);
    weekLabels = [
      for (final val in weekValues)
        weekdays[(val["date_time"] as DateTime).weekday - 1]
    ];
    monthValues =
        getValueData(HiveHelper.lastMonthIncomes, HiveHelper.lastMonthExpenses);
    monthLabels =
        List.generate(monthValues.length, (index) => "W ${index + 1}");

    for (final val in dayValues) {
      dayIncome += (val["income"] ?? 0) as int;
      dayExpense += (val["expense"] ?? 0) as int;
    }

    for (final val in weekValues) {
      weekIncome += (val["income"] ?? 0) as int;
      weekExpense += (val["expense"] ?? 0) as int;
    }

    for (final val in monthValues) {
      monthIncome += (val["income"] ?? 0) as int;
      monthExpense += (val["expense"] ?? 0) as int;
    }

    super.initState();
  }

  List<Map<String, dynamic>> getValueData(
    List<List<IncomeTransactionModel>> incomes,
    List<List<ExpenseTransactionModel>> expenses,
  ) {
    final Map<String, Map<String, dynamic>> map = {};
    for (final a in expenses) {
      int exp = [for (final item in a) item.amount]
          .reduce((value, element) => value + element);
      if (map[a.first.dateTime.ymd.simpleFormat] == null) {
        map[a.first.dateTime.ymd.simpleFormat] = {};
      }
      map[a.first.dateTime.ymd.simpleFormat]?["expense"] = exp;
      map[a.first.dateTime.ymd.simpleFormat]?["date_time"] = a.first.dateTime;
      map[a.first.dateTime.ymd.simpleFormat]?["income"] = 0;
    }

    for (final a in incomes) {
      int inc = [for (final item in a) item.amount]
          .reduce((value, element) => value + element);
      if (map[a.first.dateTime.ymd.simpleFormat] == null) {
        map[a.first.dateTime.ymd.simpleFormat] = {};
      }
      map[a.first.dateTime.ymd.simpleFormat]?["income"] = inc;
    }
    return map.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 16),
      children: [
        Container(
          height: 142,
          decoration: ShapeDecoration(
            color: const Color(0xFF2289E9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(10, 17, 10, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Activities',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  ActionButton(
                    text: "Day",
                    onTap: () {
                      setState(() {
                        currentRangeIndex = 0;
                      });
                    },
                    isSelected: currentRangeIndex == 0,
                  ).expanded(),
                  const SizedBox(
                    width: 14,
                  ),
                  ActionButton(
                    text: "Week",
                    onTap: () {
                      setState(() {
                        currentRangeIndex = 1;
                      });
                    },
                    isSelected: currentRangeIndex == 1,
                  ).expanded(),
                  const SizedBox(
                    width: 14,
                  ),
                  ActionButton(
                    text: "Month",
                    onTap: () {
                      setState(() {
                        currentRangeIndex = 2;
                      });
                    },
                    isSelected: currentRangeIndex == 2,
                  ).expanded(),
                ],
              ),
            ],
          ),
        ).paddingOnly(bottom: 24),
        () {
          final dayTotal = dayIncome + dayExpense;
          final weekTotal = weekIncome + weekExpense;
          final monthTotal = monthIncome + monthExpense;
          return DiagramWidget(
            maxValue: currentRangeIndex == 0
                ? dayTotal
                : currentRangeIndex == 1
                    ? weekTotal
                    : monthTotal,
            bottomLabels: currentRangeIndex == 0
                ? dayLabels
                : currentRangeIndex == 1
                    ? weekLabels
                    : monthLabels,
            data: currentRangeIndex == 0
                ? dayValues
                : currentRangeIndex == 1
                    ? weekValues
                    : monthValues,
          ).paddingOnly(bottom: 24);
        }(),
        Container(
          width: double.maxFinite,
          height: 60,
          decoration: ShapeDecoration(
            color: const Color(0xFF0966BD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Total amount',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ).expanded(),
              () {
                final dayTotal = dayIncome + dayExpense;
                final weekTotal = weekIncome + weekExpense;
                final monthTotal = monthIncome + monthExpense;
                return Text(
                  '\$ ${currentRangeIndex == 0 ? dayTotal : currentRangeIndex == 1 ? weekTotal : monthTotal}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                );
              }(),
            ],
          ).paddingSymetric(horizontal: 30),
        ).paddingOnly(bottom: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: ShapeDecoration(
            color: const Color(0xFF0966BD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF3BFF93),
                      shape: OvalBorder(),
                    ),
                  ).paddingOnly(right: 12),
                  const Text(
                    'Income',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ).expanded(),
                  Text(
                    '\$${currentRangeIndex == 0 ? dayIncome : currentRangeIndex == 1 ? weekIncome : monthIncome}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ).paddingOnly(bottom: 12),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFF96F25),
                      shape: OvalBorder(),
                    ),
                  ).paddingOnly(right: 12),
                  const Text(
                    'Expense',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ).expanded(),
                  Text(
                    '\$${currentRangeIndex == 0 ? dayExpense : currentRangeIndex == 1 ? weekExpense : monthExpense}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
