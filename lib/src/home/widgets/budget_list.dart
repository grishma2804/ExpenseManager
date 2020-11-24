import 'package:expense_manager/src/home/models/budget.dart';
import 'package:expense_manager/src/home/widgets/budget_item.dart';
import 'package:flutter/material.dart';

class BudgetList extends StatelessWidget {
  const BudgetList({
    Key key,
    @required this.budgetList,
  }) : super(key: key);

  final List<Budget> budgetList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: budgetList.length,
        itemBuilder: (context, position) {
          return Padding(
              padding: EdgeInsets.only(top: 10),
              child: BudgetItem(
                icon: Icons.add_circle_outline,
                budget: budgetList[position],
                color: Colors.white,
                position: position,
                onPressed: () {},
              ));
        });
  }
}
