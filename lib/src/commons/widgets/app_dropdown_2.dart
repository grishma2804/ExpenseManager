import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:expense_manager/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:equatable/equatable.dart';
class AppDropDown2Item extends Equatable {
  final dynamic code;
  final String title;
  final Map<String, dynamic> meta;

  AppDropDown2Item(this.code, this.title, {this.meta});
  @override
  List<Object> get props => [code, title, meta,];


}

class AppDropDown2 extends StatelessWidget {
  final List<AppDropDown2Item> items;
  final Function(AppDropDown2Item down2item) onSelect;
  final String hintText;
  final AppDropDown2Item selected;
  final String helpText;



  AppDropDown2({
    @required this.items,
    @required this.onSelect,
    this.hintText = "",
    @required this.selected,
    this.helpText = ""
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size( AppConstants.screenWidth,  AppConstants.screenHeight),
        allowFontScaling: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AppDropDown2Item>(
              value:  selected,
              style: TextStyle(color: Colors.black, fontSize: 14),
              items: items.map((AppDropDown2Item e){
                return DropdownMenuItem(
                  child: Container(
                    child: Text(
                      e.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  value: e,
                );
              } ).toList(),
              onChanged: onSelect,
              hint: Text(hintText),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          margin: const EdgeInsets.only(bottom: 3),
          width: double.infinity,
          height: 1,
          color: AppColors.semiBlack,
        ),
        Text(helpText, style: TextStyle(color: AppColors.mainGrey, fontSize: 14),)
      ],
    );
  }
}
