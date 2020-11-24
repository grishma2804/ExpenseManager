import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_manager/src/home/models/budget.dart';
import 'package:expense_manager/src/home/models/expense.dart';
import 'package:expense_manager/src/home/services/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService homeService;

  HomeBloc(this.homeService) : super(InitialWalletState());

  HomeState get initialState => InitialWalletState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is SaveExpense) {
      yield SavingExpense();
      List<Expense> expenses = await homeService.saveExpense(event.expense);
      yield ExpenseAdded(expenses);
    } else if (event is GetExpenses) {
      yield GettingExpenses();
      List<Expense> expenses = await homeService.getExpenses();
      yield ExpensesReturned(expenses);
    } else if (event is GetFilteredExpenses) {
      yield GettingExpenses();
      List<Expense> expenses =
          await homeService.getFilteredExpenses(event.category);
      yield ExpenseFiltered(expenses);
    } else if (event is SaveBudget) {
      List<Budget> budget = await homeService.saveBudget(event.budget);
      yield BudgetAdded(budget);
    } else if (event is GetBudget) {
      yield GettingExpenses();
      List<Budget> budget = await homeService.getBudgetList();
      yield BudgetListReturned(budget);
    }
  }
}
