import 'package:equatable/equatable.dart';
import 'package:potty/features/potties_manager/domain/entities/sorting_logic.dart';

import 'pot.dart';

/// WARNING: all double fields must be decimal formatted
class PotSet extends Equatable {
  late String id;
  late String name;
  late double income;
  late DateTime createdDate;
  List<Pot> pots;
  double? unallocatedBalance;
  double? unallocatedPercent;
  late SortingLogic sortingLogic;

  PotSet({
    required this.id,
    required this.income,
    required this.name,
    required this.createdDate,
    this.pots = const [],
    this.unallocatedBalance,
    this.unallocatedPercent,
    this.sortingLogic = SortingLogic.highToLow,
  }) {
    _calculate();
  }

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

  void setSorting(SortingLogic newSortingLogic) {
    sortingLogic = newSortingLogic;
    _sortPots();
  }

  void _sortPots() {
    if (sortingLogic == SortingLogic.highToLow) {
      pots.sort((potA, potB) => potB.percent!.compareTo(potA.percent!));
    } else if (sortingLogic == SortingLogic.lowToHigh) {
      pots.sort((potA, potB) => potA.percent!.compareTo(potB.percent!));
    } else {}
  }

  /// Changes income value in current PotSet
  /// WARNING: newIncome must be positive decimal
  void changeIncome({required double newIncome}) {
    income = newIncome;
    _calculate();
  }

  void changePotSetName({required String newName}) {
    name = newName;
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
    _sortPots();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        income,
        createdDate,
        pots,
        unallocatedBalance,
        unallocatedPercent,
      ];

  @override
  String toString() {
    return """\n 
POTSET
     Name: $name
     ID: $id
     Income: $income rubles
     createdDate: ${createdDate.hour}:${createdDate.minute} 
     UnallocatedBalance: $unallocatedBalance rubles
     UnallocatedPercent: $unallocatedPercent %
     pots: ${pots.toString()}""";
  }
}
