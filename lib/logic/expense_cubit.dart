import 'package:expense_tracker_app/data/models/expanse_model.dart';
import 'package:expense_tracker_app/data/repositories/interface_expense_repository.dart';
import 'package:expense_tracker_app/logic/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final InterfaceExpenseRepository repository;

  ExpenseCubit(this.repository) : super(Initial());

  Future<void> getAllData() async {
    emit(Loading());
    try {
      final expenses = repository.getAll();
      emit(Loaded(expenses));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await repository.addExpense(expense);
      await getAllData();
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> updateExpense(int index, Expense expense) async {
    try {
      await repository.updateExpense(index, expense);
      await getAllData();
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> deleteExpense(int index) async {
    try {
      await repository.deleteExpense(index);
      await getAllData();
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
