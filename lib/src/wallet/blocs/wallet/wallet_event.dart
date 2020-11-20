part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

@immutable
class SaveExpense extends WalletEvent {
  final Expense expense;

  SaveExpense(this.expense);
  @override
  List<Object> get props => [expense];
}

@immutable
class SaveBudget extends WalletEvent {
  final Budget budget;

  SaveBudget(this.budget);
  @override
  List<Object> get props => [budget];
}

@immutable
class GetExpenses extends WalletEvent {
  GetExpenses();
  @override
  List<Object> get props => [];
}

@immutable
class GetFilteredExpenses extends WalletEvent {
  final String category;
  GetFilteredExpenses(this.category);
  @override
  List<Object> get props => [category];
}





