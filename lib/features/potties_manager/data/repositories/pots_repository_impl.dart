import 'package:dartz/dartz.dart';
import 'package:potty/features/potties_manager/data/datasources/local_datasource.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/pot.dart';
import '../../domain/entities/pot_set.dart';
import '../../domain/repositories/pots_repository.dart';
import '../../domain/usecases/sort_pot.dart';

class PotsRepositoryImpl implements IPotsRepository {
  late ILocalDatasource localDatasource;

  PotsRepositoryImpl({required this.localDatasource});

  @override
  late List<PotSet> potsets;

  @override
  Future<void> addPot(String potSetId, Pot newPot) async {
    final currentPotSet = _definePotSet(potSetId);
    currentPotSet.addPot(newPot: newPot);
    await localDatasource.saveToMemory(currentPotSet);
  }

  @override
  Future<void> addPotSet(PotSet potSet) async {
    potsets.add(potSet);
    await localDatasource.saveToMemory(potSet);
  }

  @override
  Future<void> changePotSetIncome(String potSetId, double newIncome) async {
    final currentPotSet = _definePotSet(potSetId);
    currentPotSet.changeIncome(newIncome: newIncome);
    await localDatasource.saveToMemory(currentPotSet);
  }

  @override
  Future<void> changePotSetName(String potSetId, String newName) async {
    final currentPotSet = _definePotSet(potSetId);
    currentPotSet.changePotSetName(newName: newName);
    await localDatasource.saveToMemory(currentPotSet);
  }

  @override
  Future<void> deletePot(String potSetId, String potId) async {
    final currentPotSet = _definePotSet(potSetId);
    currentPotSet.pots.removeWhere((element) => element.id == potId);
    await localDatasource.saveToMemory(currentPotSet);
  }

  @override
  Future<void> deletePotSet(String potSetId) async {
    potsets.removeWhere((element) => element.id == potSetId);
    await localDatasource.deletePotSet(potSetId);
  }

  @override
  Stream<Either<Failure, List<PotSet>>> getAllPots() {
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

  PotSet _definePotSet(String potSetId) {
    return potsets.firstWhere((potSet) => potSet.id == potSetId);
  }
}
