import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:potty/features/potties_manager/data/datasources/local_datasource_impl.dart';
import 'package:potty/features/potties_manager/data/models/pot_model.dart';
import 'package:potty/features/potties_manager/data/models/pot_set_model.dart';
import 'package:potty/features/potties_manager/data/models/sorting_logic_model.dart';
import 'package:potty/features/potties_manager/data/repositories/pots_repository_impl.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';

import '../../domain/entities/pot_set_test.dart';

final mockPotSet = PotSet(
  id: 'id1',
  income: 100,
  name: 'PotSetReposTest',
  pots: [],
  createdDate: DateTime.now(),
)..changeIncome(newIncome: 1000);

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
        "should save potset to memory",
        () async {
          // arrange
          localHiveDatasourceImpl.getFromMemory().listen((event) {
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
        "should add new pot to existing potset",
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
    },
  );
}
