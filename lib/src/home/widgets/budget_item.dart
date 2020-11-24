import 'package:expense_manager/src/home/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:intl/intl.dart';

class BudgetItem extends StatelessWidget {
  const BudgetItem(
      {Key key,
      @required this.icon,
      @required this.color,
      @required this.onPressed,
      @required this.position,
      @required this.budget})
      : super(key: key);

  final VoidCallback onPressed;
  final Color color;
  final Budget budget;
  final int position;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
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
                      Text(
                          "${NumberFormat.currency(name: "N ").format(budget.amount)}"),
                      Text(
                        "${budget.category}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(DateFormat("dd MMM yyyy")
                        .format(DateTime.parse(budget.createdAt))),
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
      ),
    );
  }
}
