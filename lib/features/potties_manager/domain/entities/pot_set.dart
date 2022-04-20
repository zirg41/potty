import 'package:potty/features/potties_manager/domain/entities/pot.dart';

class PotSet {
  late String id;
  late String name;
  late double income;
  List<Pot> pots;
  double? unallocatedAmount;
  double? unallocatedPercent;

  PotSet({
    required this.id,
    required this.income,
    required this.name,
    this.pots = const [],
    this.unallocatedAmount,
    this.unallocatedPercent,
  });
}
