import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_manager/src/wallet/models/budget.dart';
import 'package:expense_manager/src/wallet/models/expense.dart';
import 'package:expense_manager/src/wallet/services/wallet_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletService walletService;

  WalletBloc(this.walletService) : super(InitialWalletState());

  WalletState get initialState => InitialWalletState();

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    if (event is SaveExpense) {
      yield SavingExpense();
      List<Expense> expenses = await walletService.saveExpense(event.expense);
      yield ExpenseAdded(expenses);
    } else if (event is GetExpenses) {
      yield GettingExpenses();
      List<Expense> expenses = await walletService.getExpenses();
      print("geot exp" + expenses.toString());
      yield ExpensesReturned(expenses);
    } else if (event is GetFilteredExpenses) {
      yield GettingExpenses();
      List<Expense> expenses =
          await walletService.getFilteredExpenses(event.category);
      yield ExpenseFiltered(expenses);
    } else if (event is SaveBudget) {
      List<Budget> budget = await walletService.saveBudget(event.budget);
      yield BudgetAdded(budget);
    }
  }

  // @override
  // WalletState fromJson(Map<String, dynamic> json) {
  //   return ExpenseAdded(Expense.fromJson(json));
  // }
  //
  // @override
  // Map<String, dynamic> toJson(WalletState state) {
  //   if (state is ExpenseAdded) {
  //     return {
  //       'userWallet': state.userWallet,
  //     };
  //   }
  //   return null;
  // }
}
