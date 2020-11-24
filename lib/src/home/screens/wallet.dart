import 'package:bezier_chart/bezier_chart.dart';
import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:expense_manager/src/commons/constants/app_constants.dart';
import 'package:expense_manager/src/commons/widgets/app_dropdown.dart';
import 'package:expense_manager/src/commons/widgets/app_horizontal_line.dart';
import 'package:expense_manager/src/home/blocs/home/home_bloc.dart';
import 'package:expense_manager/src/home/models/budget.dart';
import 'package:expense_manager/src/home/models/expense.dart';
import 'package:expense_manager/src/home/widgets/budget_bottom_sheet.dart';
import 'package:expense_manager/src/home/widgets/budget_item.dart';
import 'package:expense_manager/src/home/widgets/budget_list.dart';
import 'package:expense_manager/src/home/widgets/expense_bottom_sheet.dart';
import 'package:expense_manager/src/home/widgets/expense_item.dart';
import 'package:expense_manager/src/home/widgets/expense_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Wallet extends StatefulWidget {
  static const String routeName = '/MerchantOrderDetails';
  Wallet();

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final attributeValueTextController = TextEditingController();
  HomeBloc walletBloc;
  List<Expense> expenses = [];
  List<Budget> budgetList = [];
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
    walletBloc.add(GetExpenses());
    walletBloc.add(GetBudget());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    return Scaffold(
        backgroundColor: AppColors.windowColor,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: AppColors.mainBlack),
          elevation: 0,
          title: Text(
            "Expense Manager",
            style: TextStyle(
                color: AppColors.mainBlack,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Boxicons.bx_plus),
          onPressed: () {
            _displayBottomSheet(context, EnterExpenseWidget());
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: AppColors.windowColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AppHorizontalLine(),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "This month",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BlocBuilder<HomeBloc, HomeState>(
                        buildWhen: (previous, current) =>
                            current is ExpensesReturned ||
                            current is ExpenseAdded,
                        builder: (context, state) {
                          if (state is ExpensesReturned) {
                            expenses = state.expenses;
                          } else if (state is ExpenseAdded) {
                            expenses = state.expenses;
                          }
                          return buildExpenseCountContainer();
                        }),
                    BlocBuilder<HomeBloc, HomeState>(
                        buildWhen: (previous, current) =>
                            current is BudgetListReturned ||
                            current is BudgetAdded,
                        builder: (context, state) {
                          if (state is BudgetListReturned) {
                            budgetList = state.budget;
                          } else if (state is BudgetAdded) {
                            budgetList = state.budget;
                          }
                          return buildBudgetCountContainer();
                        }),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                    width: double.maxFinite,
                    height: 50.h,
                    child: RoundedBorderDropdown(
                      onChange: (value) {
                        if (value == "All Categories") {
                          walletBloc.add(GetExpenses());
                        } else {
                          walletBloc.add(GetFilteredExpenses(value));
                        }
                      },
                      data: categoryList,
                    )),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) =>
                          current is ExpensesReturned ||
                          current is ExpenseAdded ||
                          current is ExpenseFiltered,
                      builder: (context, state) {
                        if (state is ExpensesReturned) {
                          expenses = state.expenses.toList();
                          if (expenses.isEmpty) {
                            Container();
                          } else {
                            return plotGraph(context, expenses);
                          }
                        } else if (state is ExpenseAdded) {
                          expenses = state.expenses.toList();
                          if (expenses.isEmpty) {
                            Container();
                          } else {
                            return plotGraph(context, expenses);
                          }
                        } else if (state is ExpenseFiltered) {
                          expenses = state.expenses.toList();
                          if (expenses.isEmpty) {
                            return buildEmptyDataContainer();
                          } else {
                            return plotGraph(context, expenses);
                          }
                        }
                        return Container();
                      }),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Monthly Budget",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    InkWell(
                        onTap: () {
                          _displayBottomSheet(context, EnterBudgetWidget());
                        },
                        child: Text(
                          "Add Budget",
                          style: TextStyle(color: AppColors.amber),
                        ))
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) =>
                        current is BudgetAdded || current is BudgetListReturned,
                    builder: (context, state) {
                      if (state is BudgetAdded) {
                        budgetList = state.budget;
                        return BudgetList(budgetList: budgetList);
                      } else if (state is BudgetListReturned) {
                        budgetList = state.budget;
                        if (budgetList.isEmpty) {
                          return buildEmptyBudgetContainer(context);
                        } else {
                          return BudgetList(budgetList: budgetList);
                        }
                      }
                      return buildEmptyBudgetContainer(context);
                    }),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Expenses",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(color: AppColors.amber),
                    )
                  ],
                ),
                BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) =>
                        current is ExpenseAdded || current is ExpensesReturned,
                    builder: (context, state) {
                      if (state is ExpenseAdded) {
                        expenses = state.expenses.reversed.toList();
                        if (expenses.isEmpty) {
                          return buildEmptyExpenseContainer(context);
                        } else {
                          return ExpenseList(expenses: expenses);
                        }
                      } else if (state is ExpensesReturned) {
                        expenses = state.expenses.reversed.toList();
                        if (expenses.isEmpty) {
                          return buildEmptyExpenseContainer(context);
                        } else {
                          return ExpenseList(expenses: expenses);
                        }
                      }
                      return buildEmptyExpenseContainer(context);
                    }),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ));
  }

  Container buildEmptyExpenseContainer(BuildContext context) {
    return Container(
                      height: 200.h,
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Boxicons.bxs_plus_circle,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              _displayBottomSheet(
                                  context, EnterExpenseWidget());
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Text(
                            "No expense yet, \n Create one",
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          )),
                        ],
                      ),
                    );
  }

  Container buildEmptyBudgetContainer(BuildContext context) {
    return Container(
                          height: 200.h,
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Boxicons.bxs_plus_circle,
                                  color: AppColors.primary,
                                ),
                                onPressed: () {
                                  _displayBottomSheet(
                                      context, EnterBudgetWidget());
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                  child: Text(
                                "You haven't set a budget, \n Create one",
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              )),
                            ],
                          ),
                        );
  }

  Container buildEmptyDataContainer() {
    return Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            height: 100,
                            child: Center(
                                child: Text(
                              " No Data in selected Category",
                              style:
                                  TextStyle(color: AppColors.primaryBtnText),
                            )),
                          );
  }

  Container buildBudgetCountContainer() {
    return Container(
                          width: 166.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                            color: AppColors.primary,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(
                                  69,
                                  91,
                                  99,
                                  0.08,
                                ),
                                blurRadius: 16.0.w,
                                spreadRadius: 4.0.w,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                (NumberFormat.currency(name: "N ")
                                    .format(budgetList
                                        .map((budget) => budget.amount)
                                        .toList()
                                        .fold(
                                            0,
                                            (previousValue, amount) =>
                                                previousValue + amount))
                                    .toString()),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.windowColor
                                        .withOpacity(.8)),
                              ),
                              Text(
                                "Total Budget",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.windowColor),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        );
  }

  Container buildExpenseCountContainer() {
    return Container(
      width: 166.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.red,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(
              69,
              91,
              99,
              0.08,
            ),
            blurRadius: 16.0.w,
            spreadRadius: 4.0.w,
          )
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            (NumberFormat.currency(name: "N ")
                .format(expenses
                    .map((expense) => expense.amount)
                    .toList()
                    .fold(0, (previousValue, amount) => previousValue + amount))
                .toString()),
            style: TextStyle(
                fontSize: 11, color: AppColors.windowColor.withOpacity(.8)),
          ),
          Text(
            "Total Expenses",
            style: TextStyle(fontSize: 15, color: AppColors.windowColor),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

}


void _displayBottomSheet(BuildContext context, Widget bottomSheetContent) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (ctx) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.semiGrey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  width: 50,
                  height: 6,
                ),
                SizedBox(
                  height: 10.h,
                ),
                bottomSheetContent,
              ],
            ),
          ),
        );
      });
}

Widget plotGraph(BuildContext context, List<Expense> data) {
  final fromDate = DateTime(2019, 05, 22);
  final toDate = DateTime.now();

  List<DataPoint<DateTime>> dataPointList = [];
  for (var i = 0; i < data.length; i++) {
    dataPointList.add(DataPoint<DateTime>(
        value: data[i].amount, xAxis: DateTime.parse(data[i].createdAt)));
  }

  return SizedBox(
    height: MediaQuery.of(context).size.height / 2,
    width: MediaQuery.of(context).size.width,
    child: BezierChart(
      fromDate: fromDate,
      bezierChartScale: BezierChartScale.WEEKLY,
      toDate: toDate,
      selectedDate: toDate,
      series: [
        BezierLine(
          label: "Naira",
          data: dataPointList,
        ),
      ],
      config: BezierChartConfig(
        verticalIndicatorStrokeWidth: 3.0,
        verticalIndicatorColor: Colors.black26,
        showVerticalIndicator: true,
        verticalIndicatorFixedPosition: false,
        backgroundColor: AppColors.primary,
        footerHeight: 30.0,
      ),
    ),
  );
}
