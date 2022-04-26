import 'package:potty/features/potties_manager/domain/entities/pot.dart';

abstract class ISortPot {
  List<Pot> sortPots(List<Pot> potsToSort);
}

class SortLowToHigh implements ISortPot {
  const SortLowToHigh();

  @override
  List<Pot> sortPots(List<Pot> potsToSort) {
    potsToSort.sort((potA, potB) => potA.percent!.compareTo(potB.percent!));
    return potsToSort;
  }
}

class SortHighToLow implements ISortPot {
  const SortHighToLow();

  @override
  List<Pot> sortPots(List<Pot> potsToSort) {
    potsToSort.sort((potA, potB) => potB.percent!.compareTo(potA.percent!));
    return potsToSort;
  }
}
