import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:potty/global/theme/bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/potties_manager/data/models/pot_model.dart';
import 'features/potties_manager/data/models/sorting_logic_model.dart';
import 'features/potties_manager/presentation/bloc/pots_actor/pots_bloc.dart';
import 'features/potties_manager/presentation/bloc/pots_watcher/pots_watcher_bloc.dart';

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

final sl = GetIt.instance;

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
      setSortingUseCase: sl(),
      inputConverter: sl(),
    ),
  );
  sl.registerFactory(
    () => PotsWatcherBloc(listenPotSetsStreamUseCase: sl()),
  );
  sl.registerFactory(
    () => ThemeBloc(sharedPreferences: sl()),
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
  // Hive package
  await Hive.initFlutter();
  Hive.registerAdapter(SortingLogicModelAdapter());
  Hive.registerAdapter(PotSetHiveModelAdapter());
  Hive.registerAdapter(PotHiveModelAdapter());
  final hiveBox = await Hive.openBox<PotSetHiveModel>('potSetModels');
  sl.registerLazySingleton(() => hiveBox);

  // Shared preferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  //! Date Format Localization
  await initializeDateFormatting('ru');
  Intl.defaultLocale = 'ru';
}
