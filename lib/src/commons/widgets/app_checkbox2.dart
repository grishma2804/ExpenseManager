import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:expense_manager/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckBox2 extends StatefulWidget {
  final bool value;
  final Function(bool newState) onChange;

  AppCheckBox2({@required this.value, @required this.onChange});

  @override
  _AppCheckBox2State createState() => _AppCheckBox2State();
}

class _AppCheckBox2State extends State<AppCheckBox2> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size( AppConstants.screenWidth,  AppConstants.screenHeight),
        allowFontScaling: false);
    return InkWell(
        child: Icon(
          widget.value ? Boxicons.bx_checkbox_checked : Boxicons.bx_checkbox,
          color: widget.value ? AppColors.primary : AppColors.mainGrey,
          size: 24.h,
        ),
        onTap: () {
          widget.onChange(!widget.value);
        });
  }
}
