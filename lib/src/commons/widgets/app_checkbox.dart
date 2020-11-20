import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class AppCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool newState) onChange;
  final double radius;

  AppCheckBox({@required this.value, @required this.onChange, this.radius = 5});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onChange(!value);
        },
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: !value
                    ? Border.all(color: AppColors.mainGrey, width: 2)
                    : Border.all(color: AppColors.primary, width: 2)),
            child: !value
                ? Container(
                    height: 15,
                    width: 15,
                  )
                : Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Boxicons.bx_check,
                      size: 15.0,
                      color: AppColors.primary,
                    ),
                  ),
          ),
        ));
  }
}
