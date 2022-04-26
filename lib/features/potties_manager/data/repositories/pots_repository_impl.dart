import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/pot.dart';
import '../../domain/entities/pot_set.dart';
import '../../domain/repositories/pots_repository.dart';
import '../../domain/usecases/sort_pot.dart';

class PotsRepositoryImpl implements IPotsRepository {
  @override
  late List<PotSet> potsets;

  @override
  Future<void> addPot(String potSetId, Pot newPot) {
    // TODO: implement addPot
    throw UnimplementedError();
  }

  @override
  Future<void> addPotSet(PotSet potSet) {
    // TODO: implement addPotSet
    throw UnimplementedError();
  }

  @override
  Future<void> changePotSetIncome(double newIncome) {
    // TODO: implement changePotSetIncome
    throw UnimplementedError();
  }

  @override
  Future<void> changePotSetName(String newName) {
    // TODO: implement changePotSetName
    throw UnimplementedError();
  }

  @override
  Future<void> deletePot(String potSetId, Pot newPot) {
    // TODO: implement deletePot
    throw UnimplementedError();
  }

  @override
  Future<void> deletePotSet(String potSetId) {
    // TODO: implement deletePotSet
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PotSet>>> getAllPots() {
    // TODO: implement getAllPots
    throw UnimplementedError();
  }

  @override
  Future<void> setSorting(String potSetId, ISortPot sortingLogic) {
    // TODO: implement setSorting
    throw UnimplementedError();
  }

  @override
  Future<void> updatePot(String potSetId, String potId, Pot newPot) {
    // TODO: implement updatePot
    throw UnimplementedError();
  }
}
