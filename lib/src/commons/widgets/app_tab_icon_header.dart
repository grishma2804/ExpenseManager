import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TabIconHeader extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool isActive;

  TabIconHeader(
      this.isActive,
      this.title,
      this.iconData
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Icon(iconData, color: isActive? AppColors.primary: AppColors.mainGrey,),
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                color: isActive ? AppColors.primary : AppColors.mainGrey),
          ),
          SizedBox(
            height: 7,
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