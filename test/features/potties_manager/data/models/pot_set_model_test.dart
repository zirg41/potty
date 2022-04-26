import 'package:flutter_test/flutter_test.dart';
import 'package:potty/features/potties_manager/data/models/pot_set_model.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';
import 'package:potty/features/potties_manager/domain/usecases/sort_pot.dart';

import '../../domain/entities/pot_set_test.dart';

void main() {
  final potSetBeforeConverting = PotSet(
    id: 'testId',
    income: 10000,
    name: 'test pot set name',
    pots: potList,
    createdDate: DateTime.now(),
    sortingLogic: const SortHighToLow(),
  );

  group(
    'PotSetHiveModel',
    () {
      test(
        "should create itself throught PotSet instance and convert ot back",
        () async {
          // arrange
          potSetBeforeConverting.addPot(newPot: pot4);

          // act
          final potSetModel =
              PotSetHiveModel.fromPotSetEntity(potSetBeforeConverting);
          final potSetAfterConverting = potSetModel.toPotSetEntity();

          // assert
          expect(potSetBeforeConverting, potSetAfterConverting);
        },
      );
    },
  );
}
