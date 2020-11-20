import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:expense_manager/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckBoxPositive extends StatefulWidget {
  final bool value;
  final Function(bool newState) onChange;

  AppCheckBoxPositive({@required this.value, @required this.onChange});

  @override
  _AppCheckBoxPositiveState createState() => _AppCheckBoxPositiveState();
}

class _AppCheckBoxPositiveState extends State<AppCheckBoxPositive> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size( AppConstants.screenWidth,  AppConstants.screenHeight),
        allowFontScaling: false);
    return InkWell(
        child: widget.value
            ? Icon(
          Boxicons.bxs_check_square,
          color: AppColors.primary,
          size: 35.h,
        )
            : Icon(
          Boxicons.bx_check_square,
          color: AppColors.mainGrey,
          size: 35.h,
        ),
        onTap: () {
          widget.onChange(!widget.value);
        });
  }
}
