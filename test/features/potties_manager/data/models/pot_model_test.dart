import 'package:flutter_test/flutter_test.dart';
import 'package:potty/features/potties_manager/data/models/pot_model.dart';
import 'package:potty/features/potties_manager/domain/entities/pot.dart';

void main() {
  final potBeforeConverting =
      Pot(id: '1', name: 'pot1', percent: 10, isAmountFixed: false);

  group(
    'PotHiveModel',
    () {
      test(
        "should create itself with Pot entity instance and convert back to Pot",
        () async {
          // arrange

          // act
          final potModel = PotHiveModel.fromPotEntity(potBeforeConverting);
          final potAfterConverting = potModel.toPotEntity();
          // assert
          expect(potBeforeConverting, potAfterConverting);
        },
      );
    },
  );
}
