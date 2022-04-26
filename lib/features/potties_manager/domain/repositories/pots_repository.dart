import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/pot.dart';
import '../entities/pot_set.dart';

abstract class IPotsRepository {
  Future<Either<Failure, List<PotSet>>> getAllPots();
  Future<void> addPot(String potSetId, Pot pot);
  Future<void> updatePot(String potSetId, Pot pot);
  Future<void> deletePot(String potSetId, String potId);
  Future<void> createPotSet(PotSet potSet);
  // Future<void> calculate(String potSetId);
}
