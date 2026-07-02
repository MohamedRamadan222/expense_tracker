import 'package:expense_tracker_app/data/models/expanse_model.dart';
import 'package:expense_tracker_app/logic/expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    final pickDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (pickDate != null) {
      setState(() {
        selectedDate = pickDate;
      });
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          SizedBox(height: 12),
          TextField(
            controller: noteController,
            decoration: const InputDecoration(labelText: 'Note'),
          ),
          SizedBox(height: 12),
          Text(
            'Selected Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
          ),
          SizedBox(height: 8),
          ElevatedButton(onPressed: _pickDate, child: Text('Select Date')),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (amountController.text.trim().isEmpty ||
                  noteController.text.trim().isEmpty) {
                return;
              }
              final expense = Expense(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                amount: double.parse(amountController.text),
                date: selectedDate,
                createdAt: selectedDate,
                note: noteController.text.trim(),
              );

              context.read<ExpenseCubit>().addExpense(expense);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
