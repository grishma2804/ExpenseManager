part of 'wallet_bloc.dart';

@immutable
abstract class WalletState extends Equatable {
  const WalletState();
}

class InitialWalletState extends WalletState {
  @override
  List<Object> get props => [];
}
@immutable
class ErrorWithMessageState extends WalletState {
  final String error;
  ErrorWithMessageState(this.error);
  @override
  List<Object> get props => [error];
}

class LoadingState extends WalletState {
  @override
  List<Object> get props => [];
}

@immutable
class SavingExpense extends WalletState {
  @override
  List<Object> get props => [];
}

@immutable
class GettingExpenses extends WalletState {
  @override
  List<Object> get props => [];
}

@immutable
class ExpenseAdded extends WalletState {
  final List<Expense> expenses;
  ExpenseAdded(this.expenses);

  @override
  List<Object> get props => [expenses];
}

@immutable
class BudgetAdded extends WalletState {
  final List<Budget> budget;
  BudgetAdded(this.budget);

  @override
  List<Object> get props => [budget];
}

@immutable
class ExpenseFiltered extends WalletState {
  final List<Expense> expenses;
  ExpenseFiltered(this.expenses);

  @override
  List<Object> get props => [expenses];
}

@immutable
class ExpensesReturned extends WalletState {
  final List<Expense> expenses;
  ExpensesReturned(this.expenses);

  @override
  List<Object> get props => [expenses];
}
