import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'core/util/id_generator.dart';
import 'core/util/input_converter.dart';
import 'features/potties_manager/data/datasources/i_local_datasource.dart';
import 'features/potties_manager/data/datasources/local_datasource_impl.dart';
import 'features/potties_manager/data/models/pot_set_model.dart';
import 'features/potties_manager/data/repositories/pots_repository_impl.dart';
import 'features/potties_manager/domain/repositories/i_pots_repository.dart';
import 'features/potties_manager/domain/usecases/create_pot_set_usecase.dart';
import 'features/potties_manager/domain/usecases/create_pot_usecase.dart';
import 'features/potties_manager/domain/usecases/delete_pot_set_usecase.dart';
import 'features/potties_manager/domain/usecases/delete_pot_usecase.dart';
import 'features/potties_manager/domain/usecases/edit_pot_usecase.dart';
import 'features/potties_manager/domain/usecases/edit_potset_usecase.dart';
import 'features/potties_manager/domain/usecases/listen_potsets_stream_usecase.dart';
import 'features/potties_manager/domain/usecases/set_sorting_usecase.dart';
import 'features/potties_manager/presentation/bloc/pots_bloc.dart';

final sl = GetIt.asNewInstance();

Future<void> init() async {
  //! Features - Potties Manager
  sl.registerFactory(
    () => PotsBloc(
      createPotUseCase: sl(),
      createPotSetUseCase: sl(),
      deletePotSetUseCase: sl(),
      deletePotUseCase: sl(),
      editPotUseCase: sl(),
      editPotSetUseCase: sl(),
      listenPotSetsStreamUseCase: sl(),
      setSortingUseCase: sl(),
      inputConverter: sl(),
    ),
  );

  //* Use cases
  sl.registerLazySingleton(
    () => CreatePotUseCase(
      potsRepository: sl(),
      idGenerator: PotSetIdGenerator(),
    ),
  );
  sl.registerLazySingleton(
    () => CreatePotSetUseCase(
      potsRepository: sl(),
      idGenerator: PotIdGenerator(),
    ),
  );
  sl.registerLazySingleton(() => DeletePotSetUseCase(potsRepository: sl()));
  sl.registerLazySingleton(() => DeletePotUseCase(potsRepository: sl()));
  sl.registerLazySingleton(() => EditPotUseCase(potsRepository: sl()));
  sl.registerLazySingleton(() => EditPotSetUseCase(potsRepository: sl()));
  sl.registerLazySingleton(
    () => ListenPotSetsStreamUseCase(potsRepository: sl()),
  );
  sl.registerLazySingleton(() => SetSortingUseCase(potsRepository: sl()));

  // * Repository
  sl.registerLazySingleton<IPotsRepository>(
      () => PotsRepositoryImpl(localDatasource: sl()));

  // * Datasource
  sl.registerLazySingleton<ILocalDatasource>(
      () => LocalHiveDatasourceImpl(sl()));

  // ! Core
  sl.registerLazySingleton(() => InputConverter());

  // ! External
  sl.registerLazySingleton(
    () async => await Hive.openBox<PotSetHiveModel>('potSetModels'),
  );
}
