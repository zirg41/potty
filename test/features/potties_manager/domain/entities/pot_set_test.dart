import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';

import '../../../../fixtures/mocked_pots.dart';

class MockPotSet extends Mock implements PotSet {}

void main() {
  PotSet potset =
      PotSet(id: 'id', income: 1000, name: 'name', pots: mockedPots);

  group(
    'PotSet',
    () {
      test(
        'should set proper unallocated percent',
        () {
          // act
          potset.calculateUnallocatedBalanceAndPercent();
          // assert
          expect(potset.unallocatedPercent, 30);
        },
      );
      test(
        'should set proper unallocated balance',
        () {
          // act
          potset.calculateUnallocatedBalanceAndPercent();
          // assert
          expect(potset.unallocatedBalance, 300);
        },
      );
    },
  );
}
