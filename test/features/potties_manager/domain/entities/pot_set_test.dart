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
      test(
        'should calculate pots which were created only with amounts (all isAmountFixed = true)',
        () {
          // arrange
          potset.pots = mockedPotsOnlyAmounts;
          // act
          potset.calculate();
          // assert
          final listOfPercents = potset.pots.map((e) => e.percent).toList();

          expect(potset.unallocatedBalance, 300);
          expect(potset.unallocatedPercent, 30);
          expect(listOfPercents, [10.0, 20.0, 40.0]);
        },
      );
      test(
        'should calculate pots which were created either by amounts and percent(isAmountFixed mixed)',
        () {
          // arrange
          potset.pots = mockedPotsMixedCreatedByPercentsAndAmounts;
          // act
          potset.calculate();
          // assert
          final listOfPercents = potset.pots.map((e) => e.percent).toList();
          final listOfAmounts = potset.pots.map((e) => e.amount).toList();

          expect(potset.unallocatedBalance, 300);
          expect(potset.unallocatedPercent, 30);
          expect(listOfPercents, [10.0, 20.0, 40.0]);
          expect(listOfAmounts, [100.0, 200.0, 400.0]);
        },
      );
      test(
        'should calculate pots when income changed',
        () {
          // arrange
          potset.pots = mockedPotsFull;
          // act
          potset.changeIncome(newIncome: 10000);
          // assert
          final listOfPercents = potset.pots.map((e) => e.percent).toList();
          final listOfAmounts = potset.pots.map((e) => e.amount).toList();

          expect(potset.unallocatedBalance, 3000);
          expect(potset.unallocatedPercent, 30);
          expect(listOfPercents, [10.0, 20.0, 40.0]);
          expect(listOfAmounts, [1000.0, 2000.0, 4000.0]);
        },
      );
    },
  );
}
