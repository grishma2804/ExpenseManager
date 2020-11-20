import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RoundedBorderDropdown extends StatefulWidget {
  RoundedBorderDropdown({this.data, this.onChange});

  final List<String> data;
  final Function onChange;

  @override
  _RoundedBorderDropdownState createState() => _RoundedBorderDropdownState();
}

class _RoundedBorderDropdownState extends State<RoundedBorderDropdown> {
  final List<String> _dropdownValues = [
    "Switch Account",
    "Two",
    "Three",
    "Four",
    "Five"
  ];
  String _selected;
  List<String> data = new List<String>();

  @override
  void initState() {
    data = widget.data;
    _selected = widget.data.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 7.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(
            color: AppColors.primary, style: BorderStyle.solid, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: Icon(
            // Add this
            Icons.keyboard_arrow_down, // Add this
            color: AppColors.primary,
            size: 15, // Add this
          ),
          items:  data == null
              ? _dropdownValues
                  .map((value) => DropdownMenuItem(
                        child: Text(
                          value,
                          style: TextStyle(
                              color: AppColors.semiBlack, fontSize: 11),
                        ),
                        value: value,
                      ))
                  .toList()
              :  data
                  .map((value) => DropdownMenuItem(
                        child: Text(
                          value,
                          style: TextStyle(
                              color: AppColors.semiBlack, fontSize: 11),
                        ),
                        value: value,
                      ))
                  .toList(),
          onChanged: (String value) {
            setState(() {
              _selected = value;
            });
             widget.onChange(value);
          },
          isExpanded: false,
          value: _selected,
        ),
      ),
    );
  }
}
