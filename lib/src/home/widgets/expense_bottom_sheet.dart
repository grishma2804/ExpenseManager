import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:expense_manager/src/commons/widgets/app_dropdown.dart';
import 'package:expense_manager/src/commons/widgets/app_horizontal_line.dart';
import 'package:expense_manager/src/commons/widgets/app_snackbar.dart';
import 'package:expense_manager/src/commons/widgets/remove_text_view_focus.dart';
import 'package:expense_manager/src/home/blocs/home/home_bloc.dart';
import 'package:expense_manager/src/home/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class EnterExpenseWidget extends StatefulWidget {
  const EnterExpenseWidget({Key key}) : super(key: key);

  @override
  _EnterExpenseWidgetState createState() => _EnterExpenseWidgetState();
}

class _EnterExpenseWidgetState extends State<EnterExpenseWidget> {
  final _formKey = GlobalKey<FormState>();
  final Expense _expenseModel = new Expense();
  var isButtonDisabled = true;
  HomeBloc walletBloc;
  TextEditingController dateTextController = TextEditingController();
  final MoneyMaskedTextController _moneyMaskedTextController =
      new MoneyMaskedTextController(
          decimalSeparator: ".",
          initialValue: 0.00,
          leftSymbol: "N ",
          thousandSeparator: ",");
  List<String> categoryList = [
    "All Categories",
    "Food",
    "Transportation",
    "Rent",
    "Gift",
    "Savings",
    "Investment",
    "Others"
  ];

  @override
  void initState() {
    walletBloc = BlocProvider.of<HomeBloc>(context);
    dateTextController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    _expenseModel.createdAt = DateTime.now().toIso8601String();
    super.initState();
  }

  @override
  void dispose() {
    _moneyMaskedTextController.dispose();
    dateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 35,
            ),
            Text(
              "Add Expense",
              style: TextStyle(
                  fontSize: 18.h,
                  color: AppColors.mainBlack,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 35,
            ),
            // IconButton(
            //     icon: Icon(
            //       Boxicons.bx_x,
            //       size: 30,
            //     ),
            //     onPressed: () {
            //       Navigator.pop(context);
            //     }),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        AppHorizontalLine(),
        SizedBox(
          height: 20.h,
        ),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Notes"),
              SizedBox(
                height: 50.h,
                child: TextFormField(
                  onChanged: (final String text) {
                    _expenseModel.memo = text;
                    watchFormState();
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mainGrey),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text("Amount"),
              SizedBox(
                height: 50.h,
                child: TextFormField(
                  controller: _moneyMaskedTextController,
                  keyboardType: TextInputType.number,
                  onChanged: (final String text) {
                    _expenseModel.amount =
                        _moneyMaskedTextController.numberValue;
                    watchFormState();
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mainGrey),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text("Date"),
              TextField(
                focusNode: AlwaysDisabledFocusNode(),
                onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970),
                    lastDate: DateTime.now(),
                    errorFormatText: 'Enter valid date',
                    errorInvalidText: 'Enter date in valid range',
                  );
                  setState(() {
                    var formattedDate =
                        DateFormat("dd/MM/yyyy").format(pickedDate);
                    _expenseModel.createdAt = pickedDate.toIso8601String();
                    dateTextController.text = formattedDate.toString();
                    watchFormState();
                  });
                },
                enabled: true,
                controller: dateTextController,
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                  width: double.maxFinite,
                  height: 50.h,
                  child: RoundedBorderDropdown(
                    onChange: (value) {
                      _expenseModel.category = value;
                      watchFormState();
                    },
                    data: categoryList,
                  )),
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                height: 36.h,
              ),
            ],
          ),
        ),
        Container(
          width: 300.w,
          height: 50.h,
          child: FlatButton(
            disabledTextColor: AppColors.primaryBtnText,
            disabledColor: AppColors.mainGrey,
            textColor: AppColors.primaryBtnText,
            color: AppColors.primary,
            child: Text(
              "Save",
              style: TextStyle(fontSize: 16),
            ),
            onPressed:
                isButtonDisabled ? null : () => _addExpense(_expenseModel),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }

  void _addExpense(Expense expense) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      walletBloc.add(SaveExpense(expense));
      Navigator.pop(context);
    } else {
      AppSnackBar().show(message: "Please correct invalid fields");
    }
  }

  void watchFormState() {
    if (_expenseModel.checkIfAnyIsNull()) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }
}
