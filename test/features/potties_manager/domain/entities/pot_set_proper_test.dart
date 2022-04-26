import 'package:flutter_test/flutter_test.dart';
import 'package:potty/features/potties_manager/domain/entities/pot.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';

void main() {
  late PotSet potset;

  setUp(
    () {
      potset = PotSet(
        id: 'id',
        income: 1000,
        name: 'pot set name',
        pots: [],
        createdDate: DateTime.now(),
      );
    },
  );

  test(
    'adding pot',
    () {
      // arrange
      final newPot = Pot(
        id: 'uniqueId',
        name: 'test name',
        percent: 5,
        isAmountFixed: false,
      );
      // act
      potset.addPot(newPot: newPot);

      // assert
      expect(
        potset.pots.firstWhere((pot) => pot.id == 'uniqueId'),
        newPot,
      );
    },
  );
  test(
    'checking if unallocated percent is 100% for empty pots',
    () {
      // act
      potset.calculate();
      // assert
      expect(
        potset.unallocatedPercent,
        100,
      );
    },
  );
}
