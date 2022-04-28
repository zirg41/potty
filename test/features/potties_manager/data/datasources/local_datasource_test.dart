import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:potty/features/potties_manager/data/datasources/local_datasource_impl.dart';
import 'package:potty/features/potties_manager/data/models/pot_model.dart';
import 'package:potty/features/potties_manager/data/models/pot_set_model.dart';
import 'package:potty/features/potties_manager/data/models/sorting_logic_model.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';

void main() {
  late LocalHiveDatasourceImpl localDS;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Hive.init('D:\\database');
    Hive.registerAdapter(SortingLogicModelAdapter());
    Hive.registerAdapter(PotSetHiveModelAdapter());
    Hive.registerAdapter(PotHiveModelAdapter());
    final potSetBox = await Hive.openBox<PotSetHiveModel>('potSetModels');
    localDS = LocalHiveDatasourceImpl(potSetBox);
  });

  group(
    'localHiveDataSource',
    () {
      test(
        "should save potSet, recieve it and than delete",
        () async {
          // arrange
          final testPotSet1 = PotSet(
              id: '1',
              income: 100,
              name: 'Первая зарплата',
              pots: [],
              createdDate: DateTime.now())
            ..changeIncome(newIncome: 1000);

          final testPotSet2 = PotSet(
              id: '2',
              income: 1000,
              name: 'Вторая зарплата',
              pots: [],
              createdDate: DateTime.now())
            ..changeIncome(newIncome: 2000);

          final potSetsStream = localDS.getFromMemory();

          List<PotSet> listOfPotSets = [];
          potSetsStream.listen((event) {
            event.fold(
              (failure) {
                print(failure.toString());
              },
              (listofpotset) {
                //print(listofpotset.toString());
                listOfPotSets = listofpotset;
                print(
                  '[LOCAL DB]: There is ${listofpotset.length} potSets in memory',
                );
              },
            );
          }, onError: (e) {
            print(e);
          });

          // act 1
          await localDS.saveToMemory(testPotSet1);

          // assert 1

          expect(listOfPotSets, [testPotSet1]);

          // act 2
          await localDS.saveToMemory(testPotSet2);

          // assert 2
          expect(listOfPotSets, [testPotSet1, testPotSet2]);

          // act 3
          await localDS.deletePotSet(testPotSet1.id);

          // assert 3
          expect(listOfPotSets, [testPotSet2]);

          // act 4
          await localDS.deletePotSet(testPotSet2.id);

          // assert 4
          expect(listOfPotSets, []);
        },
      );
    },
  );
}
