import 'package:potty/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:potty/features/potties_manager/data/datasources/local_datasource.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';

class LocalDatasourceImpl implements ILocalDatasource {
  @override
  Stream<Either<Failure, List<PotSet>>> getFromMemory() {
    // TODO: implement getFromMemory
    throw UnimplementedError();
  }

  @override
  Future<void> saveToMemory(PotSet potset) {
    // TODO: implement saveToMemory
    throw UnimplementedError();
  }

  @override
  Future<void> deletePotSet(String potSetId) {
    // TODO: implement deletePotSet
    throw UnimplementedError();
  }
}
