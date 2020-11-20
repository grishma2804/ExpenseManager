import 'package:expense_manager/src/commons/constants/storage_constants.dart';
import 'package:expense_manager/src/wallet/models/budget.dart';
import 'package:expense_manager/src/wallet/models/expense.dart';
import 'package:expense_manager/src/wallet/services/api.dart';
import 'package:hive/hive.dart';

class WalletService {
  final APIService apiService;

  WalletService(this.apiService);

  Future<List<Expense>> saveExpense(Expense expense) async {
    List<Expense> expenses = List<Expense>();
    final expenseBox = await Hive.openBox(StorageConstants.USER_EXPENSES);
    expenseBox.add(expense);
    expenses.addAll(expenseBox.values.map((e) => e));
    return expenses;
  }

  Future<List<Expense>> getExpenses() async {
    List<Expense> expenses = List<Expense>();
    final expenseBox = await Hive.openBox(StorageConstants.USER_EXPENSES);
    expenses.addAll(expenseBox.values.map((e) => e));
    return expenses;
  }

  Future<List<Expense>> getFilteredExpenses(String category) async {
    List<Expense> expenses = List<Expense>();
    final expenseBox = await Hive.openBox(StorageConstants.USER_EXPENSES);
    expenses.addAll(expenseBox.values.map((e) => e));
    expenses = expenses.where((element) => element.category == category).toList();
    return expenses;
  }

  Future<List<Budget>> saveBudget(Budget budget) async {
    List<Budget> budgetList = List<Budget>();
    final expenseBox = await Hive.openBox(StorageConstants.USER_BUDGET);
    expenseBox.put(budget.category, budget);
    budgetList.addAll(expenseBox.values.map((e) => e));
    return budgetList;
  }

  Future<void> clearAllExpenses() async {
    final cartBox = await Hive.openBox(StorageConstants.USER_EXPENSES);
    await cartBox.clear();
  }

  Future<List<Expense>> removeExpense(Expense expense) async {
    List<Expense> expenses = List<Expense>();
    final expenseBox = await Hive.openBox(StorageConstants.USER_EXPENSES);
    expenseBox.delete(expense);
    expenses.addAll(expenseBox.values.map((e) => e));
    return expenses;
  }
}
