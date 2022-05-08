import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/pot_set.dart';
import '../models/pot_set_model.dart';
import 'i_local_datasource.dart';

class LocalHiveDatasourceImpl implements ILocalDatasource {
  final Box<PotSetHiveModel> _potSetBox;

  LocalHiveDatasourceImpl(this._potSetBox);

  final _outputController = StreamController<Either<Failure, List<PotSet>>>();

  final _inputController = StreamController<DatasourceEvent>();

  @override
  Stream<Either<Failure, List<PotSet>>> getFromMemory() async* {
    _inputController.stream.listen((event) {
      if (event == DatasourceEvent.update ||
          event == DatasourceEvent.initialize) {
        try {
          _outputController.sink.add(
            Right(_potSetBox.values.map((e) => e.toPotSetEntity()).toList()),
          );
        } catch (e) {
          _outputController.sink.add(
            Left(CacheFailure()),
          );
        }
      }
    });
    yield* _outputController.stream;
  }

  @override
  Future<void> saveToMemory(PotSet potset) async {
    final potSetModel = PotSetHiveModel.fromPotSetEntity(potset);
    _inputController.sink.add(DatasourceEvent.update);
    await _potSetBox.put(potset.id, potSetModel);
  }

  @override
  Future<void> deletePotSet(String potSetId) async {
    _inputController.sink.add(DatasourceEvent.update);
    await _potSetBox.delete(potSetId);
  }

  void initializeDataSource() {
    _inputController.sink.add(DatasourceEvent.initialize);
  }
}

enum DatasourceEvent {
  initialize,
  update,
}
