import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TabTextHeader extends StatelessWidget {
  final String title;
  final bool isActive;

  TabTextHeader(
      this.isActive,
      this.title,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                color: isActive ? AppColors.primary : AppColors.mainGrey),
          ),
          SizedBox(
            height: 20,
          ),
          isActive
              ? Container(
            height: 3,
            color: AppColors.primary,
          )
              : Container(),
        ],
      ),
    );
  }
}