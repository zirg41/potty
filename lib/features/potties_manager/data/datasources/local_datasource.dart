import 'package:dartz/dartz.dart';
import 'package:potty/core/errors/failure.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';

abstract class ILocalDatasource {
  Future<void> saveToMemory(PotSetModel potset);
  Future<Either<Failure, List<PotSet>>> getFromMemory();
}
