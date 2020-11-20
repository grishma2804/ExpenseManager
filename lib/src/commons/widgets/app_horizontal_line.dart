import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppHorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      color: AppColors.borderGrey,
    );
  }
}
