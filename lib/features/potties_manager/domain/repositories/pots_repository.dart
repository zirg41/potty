import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/pot.dart';
import '../entities/pot_set.dart';
import '../usecases/sort_pot.dart';

abstract class IPotsRepository {
  late List<PotSet> potsets;

  Future<Either<Failure, List<PotSet>>> getAllPots();
  Future<void> addPotSet(PotSet potSet);
  Future<void> addPot(String potSetId, Pot newPot);
  Future<void> setSorting(String potSetId, ISortPot sortingLogic);
  Future<void> updatePot(String potSetId, String potId, Pot newPot);
  Future<void> deletePot(String potSetId, Pot newPot);
  Future<void> deletePotSet(String potSetId);
  Future<void> changePotSetName(String newName);
  Future<void> changePotSetIncome(double newIncome);
}
