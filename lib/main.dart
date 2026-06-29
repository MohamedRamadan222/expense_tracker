import 'package:expense_tracker_app/data/models/expanse_model.dart';
import 'package:expense_tracker_app/data/repositories/imp_expense_repository.dart';
import 'package:expense_tracker_app/hive_registrar.g.dart';
import 'package:expense_tracker_app/logic/expense_cubit.dart';
import 'package:expense_tracker_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapters();

  await Hive.openBox<Expense>('expenses');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ExpenseCubit(ImpExpenseRepository(Hive.box<Expense>('expenses')))
            ..getAllData(),
      child: MaterialApp(title: 'Flutter Expense Tracker', home: HomeScreen()),
    );
  }
}
