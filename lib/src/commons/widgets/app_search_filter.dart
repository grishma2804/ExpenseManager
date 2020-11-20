
import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:expense_manager/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({
    Key key,
    this.hint, this.onResultUpdated
  }) : super(key: key);

  final String hint;
  final Function onResultUpdated;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size( AppConstants.screenWidth,  AppConstants.screenHeight),
        allowFontScaling: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: 20,),
        Expanded(
          child: SizedBox(height: 50.h,
            child: TextField(
              onChanged: (String searchQuery)  => onResultUpdated(searchQuery),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Boxicons.bx_search, size: 25.h,
                  color: AppColors.mainGrey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainGrey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainGrey, width: 1.0),
                ),
                hintText: hint ?? 'Search Items',
                hintStyle: TextStyle(fontSize: 11),
                isDense: true,
                // Added this
                contentPadding: EdgeInsets.all(8),
              ),
            ),
          ),
        ),
        SizedBox(width: 5,),
        IconButton(icon: Icon(Icons.filter_list), onPressed: null),
      ],
    );
  }
}
