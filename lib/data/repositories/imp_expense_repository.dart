import 'package:expense_tracker_app/data/models/expanse_model.dart';
import 'package:hive_ce/hive.dart';

import 'interface_expense_repository.dart';

class ImpExpenseRepository implements InterfaceExpenseRepository {
  final Box<Expense> _box;

  ImpExpenseRepository(this._box);

  @override
  List<Expense> getAll() {
    return _box.values.toList().reversed.toList();
  }

  @override
  Future<void> addExpense(Expense expense) async {
    await _box.add(expense);
  }

  @override
  Future<void> updateExpense(int index, Expense expense) async {
    await _box.putAt(index, expense);
  }

  @override
  Future<void> deleteExpense(int index) async {
    await _box.deleteAt(index);
  }
}
