import 'package:expense_manager/src/commons/widgets/app_checkbox_positive.dart';
import 'package:expense_manager/src/commons/widgets/app_checkbox_x.dart';
import 'package:flutter/material.dart';

class YesOrNoCheckBox extends StatefulWidget {
  final Function(bool value) groupValue;

  YesOrNoCheckBox(this.groupValue);
  @override
  _YesOrNoCheckBoxState createState() => _YesOrNoCheckBoxState();
}

class _YesOrNoCheckBoxState extends State<YesOrNoCheckBox> {
  bool valYes = false;
  bool valNo = true;

  @override
  void setState(fn) {
    super.setState(fn);
  }

  void _pushFinalValue() {
    setState(() {
      if (valYes == true) {
        widget.groupValue(true);
      } else if (valNo == true) {
        widget.groupValue(false);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppCheckBoxX(
            value: valNo,
            onChange: (bool value) {
              setState(() {
                valNo = value;
                valYes = !value;
                _pushFinalValue();
              });
            },
          ),
          SizedBox(width: 10,),
          AppCheckBoxPositive(
            value: valYes,
            onChange: (bool value) {
              setState(() {
                valNo = !value;
                valYes = value;
                _pushFinalValue();
              });
            },
          ),
        ],
      ),
    );
  }
}
