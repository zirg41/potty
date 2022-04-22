import 'pot.dart';

/// WARNING: all double fields must be decimal formatted
class PotSet {
  late String id;
  late String name;
  late double income;
  late DateTime createdDate;
  List<Pot> pots;
  double? unallocatedBalance;
  double? unallocatedPercent;

  PotSet({
    required this.id,
    required this.income,
    required this.name,
    required this.createdDate,
    this.pots = const [],
    this.unallocatedBalance,
    this.unallocatedPercent,
  });

  /// Calculates unallocatedBalance and unallocatedPercent
  /// by calculating the remains of all pots in the set
  void calculateUnallocatedBalanceAndPercent() {
    double percentSumm = 0.0;
    for (var pot in pots) {
      percentSumm += pot.percent!;
    }
    unallocatedPercent = (100 - percentSumm);
    unallocatedBalance = income * unallocatedPercent! / 100;
  }
}
