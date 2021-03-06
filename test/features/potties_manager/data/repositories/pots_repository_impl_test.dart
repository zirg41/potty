// ignore_for_file: avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:potty/features/potties_manager/data/datasources/local_datasource_impl.dart';
import 'package:potty/features/potties_manager/data/models/pot_model.dart';
import 'package:potty/features/potties_manager/data/models/pot_set_model.dart';
import 'package:potty/features/potties_manager/data/models/sorting_logic_model.dart';
import 'package:potty/features/potties_manager/data/repositories/pots_repository_impl.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';
import 'package:potty/features/potties_manager/domain/entities/sorting_logic.dart';

import '../../domain/entities/pot_set_test.dart';

final mockPotSet = PotSet(
  id: 'id1',
  income: 100,
  name: 'PotSetReposTest',
  pots: [],
  createdDate: DateTime.now(),
)..changeIncome(newIncome: 1000);

/// The test does not use mock, it uses real instance of local database
/// That's why all test must run together, not by each one seperately

void main() async {
  late PotsRepositoryImpl potsRepository;
  late LocalHiveDatasourceImpl localHiveDatasourceImpl;
  late List<PotSet> listOfPotSets;

  WidgetsFlutterBinding.ensureInitialized();
  Hive.init('D:\\database');
  Hive.registerAdapter(SortingLogicModelAdapter());
  Hive.registerAdapter(PotSetHiveModelAdapter());
  Hive.registerAdapter(PotHiveModelAdapter());

  final potSetBox = await Hive.openBox<PotSetHiveModel>('potSetModels');
  localHiveDatasourceImpl = LocalHiveDatasourceImpl(potSetBox);
  potsRepository = PotsRepositoryImpl(localDatasource: localHiveDatasourceImpl);

  setUp(() {
    listOfPotSets = [];
  });

  group(
    'PotsRepositoryImpl',
    () {
      test(
        "should save potset to memory and get saved potset from stream",
        () async {
          // arrange
          potsRepository.getPotsStream().listen((event) {
            event.fold(
              (failure) {
                print(failure.toString());
                return [];
              },
              (listofpotset) {
                print(
                  '[LOCAL DB]: There is ${listofpotset.length} potSets in memory with hashcode ${listofpotset.hashCode}',
                );
                listOfPotSets = listofpotset;
              },
            );
          });
          // act
          await potsRepository.addPotSet(mockPotSet);
          // assert

          print(
              "[Listener]: There is ${listOfPotSets.length} potSets in fetched list with hashcode ${listOfPotSets.hashCode}");

          expect(listOfPotSets, [mockPotSet]);
        },
      );
      test(
        "should add new pot to existing potset and get updated potset from stream",
        () async {
          // act
          await potsRepository.addPot(mockPotSet.id, pot1);
          // assert
          final modifiedPotSet = mockPotSet..pots = [pot1];

          print(
              "[Listener]: There is ${listOfPotSets.length} potSets in fetched list with hashcode ${listOfPotSets.hashCode}");

          expect(listOfPotSets, [modifiedPotSet]);
        },
      );
      test(
        "should change potSet income and get updated potset from stream",
        () async {
          // act
          await potsRepository.changePotSetIncome(mockPotSet.id, 5000);
          // assert
          final modifiedPotSet = mockPotSet
            ..pots = [pot1]
            ..changeIncome(newIncome: 5000);

          print(
              "[Listener]: There is ${listOfPotSets.length} potSets in fetched list with hashcode ${listOfPotSets.hashCode}");

          expect(listOfPotSets, [modifiedPotSet]);
        },
      );
      test(
        "should change potSet name and get updated potset from stream",
        () async {
          // act
          await potsRepository.changePotSetName(
              mockPotSet.id, "New potset name");
          // assert
          final modifiedPotSet = mockPotSet
            ..pots = [pot1]
            ..changeIncome(newIncome: 5000)
            ..changePotSetName(newName: "New potset name");

          print(
              "[Listener]: There is ${listOfPotSets.length} potSets in fetched list with hashcode ${listOfPotSets.hashCode}");

          expect(listOfPotSets, [modifiedPotSet]);
        },
      );
      test(
        "should delete pot from potSet and get updated potset from stream",
        () async {
          // act
          await potsRepository.deletePot(mockPotSet.id, pot1.id);
          // assert
          final modifiedPotSet = mockPotSet
            ..pots = [pot1]
            ..changeIncome(newIncome: 5000)
            ..changePotSetName(newName: "New potset name")
            ..deletePot(potId: pot1.id);

          print(
              "[Listener]: There is ${listOfPotSets.length} potSets in fetched list with hashcode ${listOfPotSets.hashCode}");

          expect(listOfPotSets, [modifiedPotSet]);
        },
      );
      test(
        "should add couple pots to potSet and sort them correctly, and then get updated potset from stream",
        () async {
          // act
          await potsRepository.addPot(mockPotSet.id, pot1);
          await potsRepository.addPot(mockPotSet.id, pot2);
          await potsRepository.addPot(mockPotSet.id, pot3);
          // assert
          final modifiedPotSet = mockPotSet
            ..pots = [pot1]
            ..changeIncome(newIncome: 5000)
            ..changePotSetName(newName: "New potset name")
            ..deletePot(potId: pot1.id)
            ..addPot(newPot: pot1)
            ..addPot(newPot: pot2)
            ..addPot(newPot: pot3);

          print(
              "[Listener]: There is ${listOfPotSets.length} potSets in fetched list with hashcode ${listOfPotSets.hashCode}");

          expect(listOfPotSets, [modifiedPotSet]);
        },
      );
      test(
        "should add couple pots to potSet and sort them correctly, and then get updated potset from stream",
        () async {
          // act
          await potsRepository.setSorting(
            mockPotSet.id,
            SortingLogic.lowToHigh,
          );
          // assert
          final modifiedPotSet = mockPotSet
            ..pots = [pot1]
            ..changeIncome(newIncome: 5000)
            ..changePotSetName(newName: "New potset name")
            ..deletePot(potId: pot1.id)
            ..addPot(newPot: pot1)
            ..addPot(newPot: pot2)
            ..addPot(newPot: pot3)
            ..setSorting(SortingLogic.lowToHigh);

          print(
              "[Listener]: There is ${listOfPotSets.length} potSets in fetched list with hashcode ${listOfPotSets.hashCode}");

          expect(listOfPotSets, [modifiedPotSet]);
        },
      );
      test(
        "should update pot in potSet and then get updated potset from stream",
        () async {
          // act
          await potsRepository.updatePot(mockPotSet.id, pot3.id, pot4);
          // assert
          final modifiedPotSet = mockPotSet
            ..pots = [pot1]
            ..changeIncome(newIncome: 5000)
            ..changePotSetName(newName: "New potset name")
            ..deletePot(potId: pot1.id)
            ..addPot(newPot: pot1)
            ..addPot(newPot: pot2)
            ..addPot(newPot: pot3)
            ..setSorting(SortingLogic.lowToHigh)
            ..updatePot(potId: pot3.id, newPot: pot4);

          print(
              "[Listener]: There is ${listOfPotSets.length} potSets in fetched list with hashcode ${listOfPotSets.hashCode}");

          expect(listOfPotSets, [modifiedPotSet]);
        },
      );
      test(
        "should delete potSet and then get updated potset list from stream",
        () async {
          // act
          await potsRepository.deletePotSet(mockPotSet.id);
          // assert
          print(
              "[Listener]: There is ${listOfPotSets.length} potSets in fetched list with hashcode ${listOfPotSets.hashCode}");

          expect(listOfPotSets, []);
        },
      );
    },
  );
}
