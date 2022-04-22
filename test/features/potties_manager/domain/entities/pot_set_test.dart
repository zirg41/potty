import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';

import '../../../../fixtures/mocked_pots.dart';

class MockPotSet extends Mock implements PotSet {}

void main() {
  PotSet potset =
      PotSet(id: 'id', income: 1000, name: 'name', createdDate: DateTime.now());

  group(
    'PotSet',
    () {
      test(
        'should set proper unallocated percent',
        () {
          // arrange
          potset.pots = mockedPotsFull;
          // act
          potset.calculateUnallocatedBalanceAndPercent();
          // assert
          expect(potset.unallocatedPercent, 30);
        },
      );
      test(
        'should set proper unallocated balance',
        () {
          // arrange
          potset.pots = mockedPotsFull;
          // act
          potset.calculateUnallocatedBalanceAndPercent();
          // assert
          expect(potset.unallocatedBalance, 300);
        },
      );
      test(
        'should calculate pots which were created only with percents (all isAmountFixed = false)',
        () {
          // arrange
          potset.pots = mockedPotsOnlyPercents;
          // act
          potset.calculate();
          // assert
          expect(potset.unallocatedBalance, 300);
          final listOfAmounts = potset.pots.map((e) => e.amount).toList();
          expect(listOfAmounts, [100.0, 200.0, 400.0]);
        },
      );
    },
  );
}
