import '../usecases/sort_pot.dart';
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
  late ISortPot sortingLogic;

  PotSet({
    required this.id,
    required this.income,
    required this.name,
    required this.createdDate,
    this.pots = const [],
    this.unallocatedBalance,
    this.unallocatedPercent,
    this.sortingLogic = const SortLowToHigh(),
  });

  void addPot({required Pot newPot}) {
    pots.add(newPot);
    _calculate();
  }

  void updatePot({required String potId, required Pot newPot}) {
    final potIndex = pots.indexWhere(
      (pot) => pot.id == potId,
    );

    pots[potIndex] = newPot;

    _calculate();
  }

  void deletePot({required String potId}) {
    pots.removeWhere((pot) => pot.id == potId);

    _calculate();
  }

  void setSorting() {
    pots = sortingLogic.sortPots(pots);
  }

  /// Changes income value in current PotSet
  /// WARNING: newIncome must be positive decimal
  void changeIncome({required double newIncome}) {
    income = newIncome;
    _calculate();
  }

  /// Calculates unallocatedBalance and unallocatedPercent
  /// by calculating the remains of all pots in the set
  void _calculateUnallocatedBalanceAndPercent() {
    double percentSumm = 0.0;
    for (var pot in pots) {
      percentSumm += pot.percent!;
    }
    unallocatedPercent = (100 - percentSumm);
    unallocatedBalance = income * unallocatedPercent! / 100;
  }

  void _calculate() {
    for (var pot in pots) {
      if (!pot.isAmountFixed!) {
        pot.amount = income * pot.percent! / 100;
      } else {
        pot.percent = pot.amount! / income * 100;
      }
    }
    _calculateUnallocatedBalanceAndPercent();
    setSorting();
  }
}
