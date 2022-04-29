import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:potty/core/util/id_generator.dart';
import 'package:potty/features/potties_manager/data/datasources/i_local_datasource.dart';
import 'package:potty/features/potties_manager/data/datasources/local_datasource_impl.dart';
import 'package:potty/features/potties_manager/data/models/pot_model.dart';
import 'package:potty/features/potties_manager/data/models/pot_set_model.dart';
import 'package:potty/features/potties_manager/data/models/sorting_logic_model.dart';
import 'package:potty/features/potties_manager/data/repositories/pots_repository_impl.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';
import 'package:potty/features/potties_manager/domain/repositories/i_pots_repository.dart';
import 'package:potty/features/potties_manager/domain/usecases/create_pot_set_usecase.dart';

void main() {
  late CreatePotSetUseCase createPotSetUseCase;
  late IPotsRepository potsRepository;
  late IDGenerator idGenerator;
  late ILocalDatasource localDatasource;
  late List<PotSet> listOfPotSets;
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init('D:\\database');
  Hive.registerAdapter(SortingLogicModelAdapter());
  Hive.registerAdapter(PotSetHiveModelAdapter());
  Hive.registerAdapter(PotHiveModelAdapter());

  setUp(() async {
    final potSetBox = await Hive.openBox<PotSetHiveModel>('potSetModels');
    localDatasource = LocalHiveDatasourceImpl(potSetBox);
    potsRepository = PotsRepositoryImpl(localDatasource: localDatasource);
    idGenerator = PotSetIdGenerator();

    createPotSetUseCase = CreatePotSetUseCase(
        potsRepository: potsRepository, idGenerator: idGenerator);
    listOfPotSets = [];
  });

  group(
    'CreatePotSetUseCase',
    () {
      test(
        "should add new PotSet and verify it calculated",
        () async {
          // arrange
          potsRepository.getAllPots().listen((event) {
            event.fold(
              (failure) {
                print(failure.toString());
                return [];
              },
              (listofpotset) {
                listOfPotSets = listofpotset;
              },
            );
          });

          // act
          await createPotSetUseCase.call('test name', 1000);
          await Future.delayed(const Duration(milliseconds: 1));
          // assert
          expect(
              listOfPotSets
                  .firstWhere((element) => element.name == 'test name')
                  .income,
              1000);
          expect(
              listOfPotSets
                  .firstWhere((element) => element.name == 'test name')
                  .unallocatedBalance,
              1000);
          expect(
              listOfPotSets
                  .firstWhere((element) => element.name == 'test name')
                  .unallocatedPercent,
              100);
        },
      );
    },
  );
}
