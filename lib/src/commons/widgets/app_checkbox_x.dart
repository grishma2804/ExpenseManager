import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:expense_manager/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckBoxX extends StatefulWidget {
  final bool value;
  final Function(bool newState) onChange;

  AppCheckBoxX({@required this.value, @required this.onChange});

  @override
  _AppCheckBoxXState createState() => _AppCheckBoxXState();
}

class _AppCheckBoxXState extends State<AppCheckBoxX> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size( AppConstants.screenWidth,  AppConstants.screenHeight),
        allowFontScaling: false);
    return InkWell(
        child: widget.value
            ? Icon(
                Boxicons.bxs_x_square,
                color: AppColors.primary,
                size: 35.h,
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Boxicons.bx_square,
                    color: AppColors.mainGrey,
                    size: 35.h,
                  ),
                  Icon(
                    Icons.clear,
                    color: AppColors.mainGrey,
                    size: 15.h,
                  ),
                ],
              ),
        onTap: () {
          widget.onChange(!widget.value);
        });
  }
}
