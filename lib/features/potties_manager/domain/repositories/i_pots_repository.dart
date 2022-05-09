import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/pot.dart';
import '../entities/pot_set.dart';
import '../entities/sorting_logic.dart';

abstract class IPotsRepository {
  late List<PotSet> potsets;

  Stream<Either<Failure, List<PotSet>>> getAllPots();
  Future<void> addPotSet(PotSet potSet);
  Future<void> addPot(String potSetId, Pot newPot);
  Future<void> setSorting(String potSetId, SortingLogic sortingLogic);
  Future<void> updatePot(String potSetId, String potId, Pot newPot);
  Future<void> deletePot(String potSetId, String potId);
  Future<void> deletePotSet(String potSetId);
  Future<void> changePotSetName(String potSetId, String newName);
  Future<void> changePotSetIncome(String potSetId, double newIncome);
}
