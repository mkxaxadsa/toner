// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finance_app/core/constants/app_icons.dart';
import 'package:finance_app/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance_app/core/extensions/mediaquery_ext_on_context.dart';
import 'package:finance_app/core/extensions/padding_extension_on_widget.dart';
import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key,
    required this.currentPageIndex,
    required this.onChanged,
  }) : super(key: key);
  final int currentPageIndex;
  final void Function(int pageIndex) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Color(0xFF2289EA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(top: 12, bottom: context.padding.bottom + 8),
      child: Row(
        children: [
          _item(
            icon: AppIcons.home,
            label: "Home",
            index: 0,
          ),
          _item(
            icon: AppIcons.activites,
            label: "Activities",
            index: 1,
          ),
          _item(
            icon: 'assets/icons/quiz.png',
            label: "Quiz/Community",
            index: 2,
          ),
          _item(
            icon: AppIcons.settings,
            label: "Settings",
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String icon,
    required String label,
    required int index,
  }) {
    final isSelected = index == currentPageIndex;
    return GestureDetector(
      onTap: () {
        onChanged(index);
      },
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              width: 25,
              color: isSelected
                  ? Colors.white
                  : const Color.fromARGB(255, 0, 0, 0),
            ).paddingOnly(bottom: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xff0966BD),
              ),
            )
          ],
        ),
      ),
    ).expanded();
  }
}
