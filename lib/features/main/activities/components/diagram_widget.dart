// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finance_app/core/extensions/expanded_ext_on_widget.dart';
import 'package:flutter/material.dart';

class DiagramWidget extends StatelessWidget {
  const DiagramWidget({
    Key? key,
    required this.maxValue,
    required this.bottomLabels,
    required this.data,
  }) : super(key: key);
  final int maxValue;
  final List<String> bottomLabels;
  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 305,
      decoration: ShapeDecoration(
        color: const Color(0xFF2289E9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          data.length,
          (index) {
            final income = data[index]["income"] as int;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 165,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF96F25),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Column(
                          children: [
                            if (maxValue - income > 0)
                              Spacer(
                                flex: maxValue - income,
                              ),
                            if (income > 0)
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF3CFF94),
                                ),
                              ).expanded(flex: income),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    bottomLabels.length,
                    (index) => Text(
                      bottomLabels[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
