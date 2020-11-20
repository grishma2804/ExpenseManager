import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppVerticalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 1,
      color: AppColors.semiGrey,
    );
  }
}
