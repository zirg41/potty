import 'package:flutter_test/flutter_test.dart';
import 'package:potty/features/potties_manager/domain/entities/pot.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';

final pot1 = Pot(id: '1', name: 'pot1', percent: 10, isAmountFixed: false);
final pot2 = Pot(id: '2', name: 'pot2', amount: 150, isAmountFixed: true);
final pot3 = Pot(id: '3', name: 'pot3', amount: 250, isAmountFixed: true);
final pot4 = Pot(id: '4', name: 'pot4', percent: 30, isAmountFixed: false);

final potList = [pot1, pot2, pot3];

void main() {
  late PotSet potset;

  setUp(
    () {
      potset = PotSet(
        id: 'test_id',
        income: 1000,
        name: 'test name',
        createdDate: DateTime.utc(2022),
        pots: [],
      );
    },
  );

  group(
    'PotSet',
    () {
      test(
        "should add new Pot, calculate pot and remains",
        () async {
          // act
          potset.addPot(newPot: pot1);
          // assert
          expect(potset.pots[0], pot1);
          expect(potset.pots[0].amount, 100);
          expect(potset.unallocatedPercent, 90);
          expect(potset.unallocatedBalance, 900);
          // act
          potset.addPot(newPot: pot2);
          // assert
          expect(potset.pots[1], pot2);
          expect(potset.pots[1].percent, 15);
          expect(potset.unallocatedPercent, 75);
          expect(potset.unallocatedBalance, 750);
        },
      );

      test(
        "should update existing Pot and calculate",
        () async {
          // arrange
          potset.pots = potList;
          // act
          potset.updatePot(potId: potList[2].id, newPot: pot4);
          // assert
          expect(potset.pots[2], pot4);
          expect(potset.unallocatedBalance, 450);
        },
      );
      test(
        "should delete Pot and calculate",
        () async {
          // arrange
          potset.pots = potList;
          // act
          potset.deletePot(potId: potList[2].id);
          // assert
          expect(potset.pots.length, 2);
          expect(potset.unallocatedBalance, 750);
        },
      );
    },
  );
}
