import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expanse_model.dart';
import '../../logic/expense_cubit.dart';

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  TransactionType transactionType = TransactionType.expense;

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
    amountController.clear();
    noteController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Expense'),
                  selected: transactionType == TransactionType.expense,
                  selectedColor: Colors.redAccent.withValues(alpha: 0.3),
                  onSelected: (selected) {
                    setState(() => transactionType = TransactionType.expense);
                  },
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('Income'),
                  selected: transactionType == TransactionType.income,
                  selectedColor: Colors.green.withValues(alpha: 0.3),
                  onSelected: (selected) {
                    setState(() => transactionType = TransactionType.income);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // text field
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: 'Note'),
            ),
            const SizedBox(height: 12),
            Text(
              'Selected Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _pickDate,
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 20),

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
                  type: transactionType,
                );

                context.read<ExpenseCubit>().addExpense(expense);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
