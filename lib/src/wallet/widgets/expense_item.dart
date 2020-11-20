

import 'package:dash_chat/dash_chat.dart';
import 'package:expense_manager/src/wallet/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(
      {Key key,
      @required this.icon,
      @required this.color,
      @required this.onPressed,
      @required this.position,
      @required this.expense})
      : super(key: key);

  final VoidCallback onPressed;
  final Color color;
  final Expense expense;
  final int position;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("N ${expense.amount}"),
                    Text( "${expense.category} :  ${expense.memo != null ? expense.memo : "For unspecified reason"}", overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text( DateFormat("dd MMM yyyy").format(DateTime.parse(expense.createdAt))),
                  Icon(Boxicons.bx_money)
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
