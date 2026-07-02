import 'package:expense_tracker_app/logic/expense_cubit.dart';
import 'package:expense_tracker_app/logic/expense_state.dart';
import 'package:expense_tracker_app/presentation/widgets/add_expense_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is Loading || state is Initial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Error) {
            return Center(child: Text(state.errMsg));
          } else if (state is Loaded) {
            final expenses = state.expenses;
            return ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Row(
                  children: [
                    Text(expense.amount.toString()),
                    Text(expense.note.toString()),
                    Text(expense.date.toString()),
                  ],
                );
              },
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddExpenseSheet(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
