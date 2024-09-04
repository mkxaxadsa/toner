// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:finance_app/core/data/categories.dart';
import 'package:finance_app/core/extensions/align_ext_on_widget.dart';
import 'package:finance_app/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance_app/core/extensions/hidekeyboard_ext_on_context.dart';
import 'package:finance_app/core/extensions/padding_extension_on_widget.dart';
import 'package:finance_app/core/ui_components/action_button.dart';

import 'package:finance_app/data/models/category.dart';
import 'package:finance_app/data/models/expense_transaction.dart';
import 'package:finance_app/data/models/income_transaction.dart';
import 'package:flutter/material.dart';

Future<void> showIncomeBottomsheet(
  BuildContext context,
  void Function(IncomeTransactionModel) onAdd,
) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    elevation: 0,
    builder: (context) {
      return AddTransactionBottomsheet(
        type: "Income",
        categories: incomeCategories,
        onDone: (title, amount, category) {
          onAdd(
            IncomeTransactionModel(
              title: title,
              amount: amount,
              category: category,
              dateTime: DateTime.now(),
            ),
          );
        },
      );
    },
  );
}

Future<void> showExpenseBottomsheet(
  BuildContext context,
  void Function(ExpenseTransactionModel) onAdd,
) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    elevation: 0,
    builder: (context) {
      return AddTransactionBottomsheet(
        type: "Expense",
        categories: expenseCategories,
        onDone: (title, amount, category) {
          onAdd(
            ExpenseTransactionModel(
              title: title,
              amount: amount,
              category: category,
              dateTime: DateTime.now(),
            ),
          );
        },
      );
    },
  );
}

class AddTransactionBottomsheet extends StatefulWidget {
  const AddTransactionBottomsheet({
    Key? key,
    required this.type,
    required this.categories,
    required this.onDone,
  }) : super(key: key);
  final String type;
  final List<TransactionCategory> categories;
  final void Function(String title, int amount, TransactionCategory category)
      onDone;
  @override
  State<AddTransactionBottomsheet> createState() =>
      _AddTransactionBottomsheetState();
}

class _AddTransactionBottomsheetState extends State<AddTransactionBottomsheet> {
  String title = "";
  int amount = 0;

  TransactionCategory? category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.hideKeyboard();
      },
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 16.9,
            sigmaY: 16.9,
          ),
          child: Container(
            width: double.maxFinite,
            decoration: ShapeDecoration(
              color: const Color(0x19D9D9D9).withOpacity(.1),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 5,
                  decoration: ShapeDecoration(
                    color: const Color(0x14FAFAFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.50),
                    ),
                  ),
                ).paddingOnly(top: 7).align(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Color(0xFFB3935B),
                      fontSize: 16,
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ).align(Alignment.centerRight),
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Text(
                      'Add ${widget.type}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ).paddingOnly(bottom: 10),
                    _buildInput(
                      title: "Title",
                      onChanged: (val) {
                        title = val.trim();
                      },
                    ).paddingOnly(bottom: 13, left: 9),
                    _buildInput(
                      title: "Amount(\$)",
                      onChanged: (val) {
                        amount = int.tryParse(val.trim()) ?? amount;
                      },
                      keyboardType: TextInputType.number,
                    ).paddingOnly(bottom: 13, left: 9),
                    const Text(
                      'Category',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ).paddingOnly(bottom: 13, left: 9),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 4,
                          ),
                          itemCount: widget.categories.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            final cat = widget.categories[index];
                            final isSelected = cat == category;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  category = cat;
                                });
                              },
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: Colors.white
                                      .withOpacity(0.10000000149011612),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      cat.asset,
                                      height: 50,
                                    ),
                                    Text(
                                      cat.viewText,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: ShapeDecoration(
                                        color: isSelected
                                            ? const Color(0xffB3935B)
                                            : Colors.transparent,
                                        shape: OvalBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: isSelected
                                                ? const Color(0xffB3935B)
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: isSelected
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.black,
                                              size: 13,
                                            )
                                          : null,
                                    )
                                        .paddingOnly(right: 11, top: 5)
                                        .align(Alignment.centerRight)
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ).expanded(),
                ActionButton(
                  text: "Done",
                  onTap: () {
                    if (title.isNotEmpty && amount > 0 && category != null) {
                      widget.onDone(title, amount, category!);
                      Navigator.pop(context);
                    }
                  },
                ).paddingSymetric(vertical: 25),
              ],
            ).paddingSymetric(horizontal: 16),
          ).paddingOnly(top: 30),
        ),
      ),
    );
  }

  Widget _buildInput({
    required String title,
    required void Function(String) onChanged,
    TextInputType keyboardType = TextInputType.name,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ).paddingOnly(bottom: 12),
        TextField(
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(11),
            filled: true,
            fillColor: Colors.white10,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        )
      ],
    );
  }
}
