import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:potty/features/potties_manager/domain/entities/pot.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';

import '../../../../fixtures/mocked_pots.dart';

class MockPotSet extends Mock implements PotSet {}

void _debugPotsPrint(PotSet potSets) {
  final listOfNames = potSets.pots.map((e) => e.name).toList();
  final listOfPercents = potSets.pots.map((e) => e.percent).toList();
  final listOfAmounts = potSets.pots.map((e) => e.amount).toList();
  final listOfFlags = potSets.pots.map((e) => e.isAmountFixed).toList();
  debugPrint("Names : " + listOfNames.toString());
  debugPrint("Percents: " + listOfPercents.toString());
  debugPrint("Amounts: " + listOfAmounts.toString());
  debugPrint("Flags: " + listOfFlags.toString());
}

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
      group('should calculate pots', () {
        group(
          'which were created',
          () {
            test(
              'only with percents (all isAmountFixed = false)',
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
              'only with amounts (all isAmountFixed = true)',
              () {
                // arrange
                potset.pots = mockedPotsOnlyAmounts;
                // act
                potset.calculate();
                // assert
                final listOfPercents =
                    potset.pots.map((e) => e.percent).toList();

                expect(potset.unallocatedBalance, 300);
                expect(potset.unallocatedPercent, 30);
                expect(listOfPercents, [10.0, 20.0, 40.0]);
              },
            );
            test(
              'either by amounts and percent(isAmountFixed mixed)',
              () {
                // arrange
                potset.pots = mockedPotsMixedCreatedByPercentsAndAmounts;
                // act
                potset.calculate();
                // assert
                final listOfPercents =
                    potset.pots.map((e) => e.percent).toList();
                final listOfAmounts = potset.pots.map((e) => e.amount).toList();

                expect(potset.unallocatedBalance, 300);
                expect(potset.unallocatedPercent, 30);
                expect(listOfPercents, [10.0, 20.0, 40.0]);
                expect(listOfAmounts, [100.0, 200.0, 400.0]);
              },
            );
          },
        );

        test(
          'when income changed',
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
        test(
          'when income and isAmountFixed flag changes',
          () {
            // arrange
            potset.pots = mockedPotsFull;
            // act
            potset.changeIncome(newIncome: 1000);
            potset.calculate();
            potset.pots[0].isAmountFixed = true;
            potset.changeIncome(newIncome: 10000);

            // assert
            final listOfPercents = potset.pots.map((e) => e.percent).toList();
            final listOfAmounts = potset.pots.map((e) => e.amount).toList();

            expect(potset.unallocatedBalance, 3900);
            expect(potset.unallocatedPercent, 39);
            expect(listOfPercents, [1.0, 20.0, 40.0]);
            expect(listOfAmounts, [100.0, 2000.0, 4000.0]);
          },
        );
      });
      group(
        'should add new pot',
        () {
          test(
            'by defining percent',
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
              _debugPotsPrint(potset);
              // assert
              expect(
                potset.pots.firstWhere((pot) => pot.percent == newPot.percent),
                newPot,
              );
            },
          );
          test(
            'by defining amount',
            () {
              // arrange
              final newPot = Pot(
                id: 'uniqueId2',
                name: 'test name',
                amount: 1000,
                isAmountFixed: true,
              );
              // act
              potset.addPot(newPot: newPot);
              _debugPotsPrint(potset);
              // assert
              expect(
                potset.pots.firstWhere((pot) => pot.amount == 1000),
                newPot,
              );
            },
          );
        },
      );
      group('should update existing pot', () {
        test(
          'by editing amount',
          () {
            final currentListLength = potset.pots.length;
            // arrange
            final newPot = Pot(
              id: 'uniqueId2',
              name: 'test name',
              amount: 800,
              isAmountFixed: true,
            );
            // act
            potset.updatePot(potId: newPot.id, newPot: newPot);
            _debugPotsPrint(potset);
            // assert
            expect(
              potset.pots.firstWhere((pot) => pot.id == 'uniqueId2'),
              newPot,
            );
            expect(potset.pots.length, currentListLength,
                reason: "length was not changed");
          },
        );
        test(
          'by editing percent',
          () {
            final currentListLength = potset.pots.length;
            // arrange
            final newPot = Pot(
              id: 'uniqueId2',
              name: 'test name',
              percent: 15,
              isAmountFixed: false,
            );
            // act
            potset.updatePot(potId: newPot.id, newPot: newPot);
            _debugPotsPrint(potset);
            // assert
            expect(
              potset.pots.firstWhere((pot) => pot.id == 'uniqueId2'),
              newPot,
            );
            expect(potset.pots.length, currentListLength,
                reason: "length was not changed");
          },
        );
        test(
          'by editing name',
          () {
            final currentListLength = potset.pots.length;
            // arrange
            final newPot = Pot(
              id: 'uniqueId2',
              name: 'adjusted name',
              percent: 15,
              isAmountFixed: false,
            );
            // act
            potset.updatePot(potId: newPot.id, newPot: newPot);
            _debugPotsPrint(potset);
            // assert
            expect(
              potset.pots.firstWhere((pot) => pot.id == 'uniqueId2'),
              newPot,
            );
            expect(potset.pots.length, currentListLength,
                reason: "length was not changed");
          },
        );
      });
      test(
        'should delete pot by its ID',
        () {
          final currentListLength = potset.pots.length;
          // arrange

          final potIdToDelete = 'uniqueId2';
          // act
          potset.deletePot(potId: potIdToDelete);
          _debugPotsPrint(potset);
          // assert
          expect(
            potset.pots.contains((pot) => pot.id == 'uniqueId2'),
            false,
          );
          expect(potset.pots.length, currentListLength - 1);
        },
      );
    },
  );
}
