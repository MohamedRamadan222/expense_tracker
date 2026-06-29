import 'package:hive_ce/hive_ce.dart';

part 'expanse_model.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  double amount;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String? note;

  @HiveField(4)
  DateTime createdAt;

  Expense({
    required this.id,
    required this.amount,
    required this.date,
    this.note,
    required this.createdAt,
  });
}
