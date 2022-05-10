import 'package:dartz/dartz.dart';
import '../../domain/entities/sorting_logic.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/pot.dart';
import '../../domain/entities/pot_set.dart';
import '../../domain/repositories/i_pots_repository.dart';
import '../datasources/i_local_datasource.dart';

class PotsRepositoryImpl implements IPotsRepository {
  late ILocalDatasource localDatasource;

  PotsRepositoryImpl({required this.localDatasource});

  @override
  List<PotSet> potsets = [];

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
    currentPotSet.deletePot(potId: potId);
    await localDatasource.saveToMemory(currentPotSet);
  }

  @override
  Future<void> deletePotSet(String potSetId) async {
    potsets.removeWhere((element) => element.id == potSetId);
    await localDatasource.deletePotSet(potSetId);
  }

  @override
  Stream<Either<Failure, List<PotSet>>> getPotsStream() {
    // adding potsets from memory to the potsets field to manipulate with them
    potsets = localDatasource.initializeDataSource();

    return localDatasource.getFromMemory();
  }

  @override
  Future<void> setSorting(String potSetId, SortingLogic sortingLogic) async {
    final currentPotSet = _definePotSet(potSetId);
    currentPotSet.setSorting(sortingLogic);
    await localDatasource.saveToMemory(currentPotSet);
  }

  @override
  Future<void> updatePot(String potSetId, String potId, Pot newPot) async {
    final currentPotSet = _definePotSet(potSetId);
    currentPotSet.updatePot(potId: potId, newPot: newPot);
    await localDatasource.saveToMemory(currentPotSet);
  }

  PotSet _definePotSet(String potSetId) {
    return potsets.firstWhere((potSet) => potSet.id == potSetId);
  }
}
