import 'package:expense_tracker_app/data/models/expanse_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Wallet')),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is Loading || state is Initial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Error) {
            return Center(child: Text(state.errMsg));
          } else if (state is Loaded) {
            final expenses = state.expenses;

            return Column(
              children: [
                // ----- كارت الإجماليات (الرصيد، الدخل، والمصروف) -----
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E2C), // لون داكن أنيق
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Total Balance',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${state.balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // عمود الدخل
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.white12,
                                child: Icon(Icons.arrow_downward, color: Colors.greenAccent, size: 16),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Income', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  Text(
                                    '\$${state.totalIncome.toStringAsFixed(2)}',
                                    style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // عمود المصروفات
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.white12,
                                child: Icon(Icons.arrow_upward, color: Colors.redAccent, size: 16),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Expenses', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  Text(
                                    '\$${state.totalExpense.toStringAsFixed(2)}',
                                    style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ----- قائمة العمليات (ListView) -----
                Expanded(
                  child: ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      // نحدد هل هذه العملية دخل أم مصروف
                      final isIncome = expense.type == TransactionType.income;

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          // أيقونة تتغير حسب النوع
                          leading: CircleAvatar(
                            backgroundColor: isIncome
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            child: Icon(
                              isIncome ? Icons.attach_money : Icons.money_off,
                              color: isIncome ? Colors.green : Colors.red,
                            ),
                          ),
                          title: Text(
                            expense.note.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                          ),
                          // السعر يظهر بالأخضر (+) أو بالأحمر (-)
                          trailing: Text(
                            '${isIncome ? '+' : '-'} \$${expense.amount.toString()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isIncome ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent, // لجعل حواف الـ Sheet دائرية بشكل أفضل
            builder: (_) => Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: const AddExpenseSheet(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}