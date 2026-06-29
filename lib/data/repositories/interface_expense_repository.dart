import 'package:expense_tracker_app/data/models/expanse_model.dart';

abstract interface class InterfaceExpenseRepository {
  List<Expense> getAll();

  Future<void> addExpense(Expense expense);

  Future<void> updateExpense(int index, Expense expense);

  Future<void> deleteExpense(int index);
}
