import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/pot_set.dart';

abstract class ILocalDatasource {
  Future<void> saveToMemory(PotSet potset);
  Future<void> deletePotSet(String potSetId);
  Stream<Either<Failure, List<PotSet>>> getFromMemory();
  List<PotSet> initializeDataSource();
}
