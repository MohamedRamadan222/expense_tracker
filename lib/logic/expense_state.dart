import 'package:expense_tracker_app/data/models/expanse_model.dart';

abstract class ExpenseState {}

class Initial extends ExpenseState {}

class Loading extends ExpenseState {}

class Loaded extends ExpenseState {
  final List<Expense> expenses;

  Loaded(this.expenses);

  double get totalAmount {
    return expenses.fold(0.0, (sum, item) => sum + item.amount);
  }
}

class Error extends ExpenseState {
  final String errMsg;

  Error(this.errMsg);
}

class ExpenseOperationSuccess extends ExpenseState {
  final String message;

  ExpenseOperationSuccess(this.message);
}
