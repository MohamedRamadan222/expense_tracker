import 'package:hive_ce/hive.dart';

part 'expanse_model.g.dart';


@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0)
  income,

  @HiveField(1)
  expense,
}

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final String note;

  @HiveField(5, defaultValue: TransactionType.expense)
  final TransactionType type;

  Expense({
    required this.id,
    required this.amount,
    required this.date,
    required this.createdAt,
    required this.note,
    required this.type,
  });
}