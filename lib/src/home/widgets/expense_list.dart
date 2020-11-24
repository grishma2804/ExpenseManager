import 'package:expense_manager/src/home/models/expense.dart';
import 'package:expense_manager/src/home/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    Key key,
    @required this.expenses,
  }) : super(key: key);

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: expenses.take(5).length,
        itemBuilder: (context, position) {
          return Padding(
              padding: EdgeInsets.only(top: 10),
              child: ExpenseItem(
                icon: Icons.add_circle_outline,
                expense: expenses[position],
                color: Colors.white,
                position: position,
                onPressed: () {},
              ));
        });
  }
}