import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:potty/core/util/input_converter.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';
import 'package:potty/features/potties_manager/domain/usecases/create_pot_set_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/create_pot_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/delete_pot_set_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/delete_pot_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/edit_pot_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/edit_potset_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/listen_potsets_stream_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/set_sorting_usecase.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_bloc.dart';

class MockCreatePotSetUseCase extends Mock implements CreatePotSetUseCase {}

class MockCreatePotUseCase extends Mock implements CreatePotUseCase {}

class MockEditPotUseCase extends Mock implements EditPotUseCase {}

class MockDeletePotUseCase extends Mock implements DeletePotUseCase {}

class MockEditPotSetUseCase extends Mock implements EditPotSetUseCase {}

class MockDeletePotSetUseCase extends Mock implements DeletePotSetUseCase {}

class MockListenPotSetsStreamUseCase extends Mock
    implements ListenPotSetsStreamUseCase {}

class MockSetSortingUseCase extends Mock implements SetSortingUseCase {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late PotsBloc bloc;
  late MockCreatePotUseCase mockCreatePotUseCase;
  late MockEditPotUseCase mockEditPotUseCase;
  late MockDeletePotUseCase mockDeletePotUseCase;
  late MockCreatePotSetUseCase mockCreatePotSetUseCase;
  late MockEditPotSetUseCase mockEditPotSetUseCase;
  late MockDeletePotSetUseCase mockDeletePotSetUseCase;
  late MockListenPotSetsStreamUseCase mockListenPotSetsStreamUseCase;
  late MockSetSortingUseCase mockSetSortingUseCase;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockCreatePotUseCase = MockCreatePotUseCase();
    mockEditPotUseCase = MockEditPotUseCase();
    mockDeletePotUseCase = MockDeletePotUseCase();
    mockCreatePotSetUseCase = MockCreatePotSetUseCase();
    mockEditPotSetUseCase = MockEditPotSetUseCase();
    mockDeletePotSetUseCase = MockDeletePotSetUseCase();
    mockListenPotSetsStreamUseCase = MockListenPotSetsStreamUseCase();
    mockSetSortingUseCase = MockSetSortingUseCase();
    mockInputConverter = MockInputConverter();

    bloc = PotsBloc(
        createPotUseCase: mockCreatePotUseCase,
        createPotSetUseCase: mockCreatePotSetUseCase,
        deletePotSetUseCase: mockDeletePotSetUseCase,
        deletePotUseCase: mockDeletePotUseCase,
        editPotUseCase: mockEditPotUseCase,
        editPotSetUseCase: mockEditPotSetUseCase,
        listenPotSetsStreamUseCase: mockListenPotSetsStreamUseCase,
        setSortingUseCase: mockSetSortingUseCase,
        inputConverter: mockInputConverter);
  });

  group(
    'CreatePotSetEvent',
    () {
      const String potSetNameFromUI = 'Test PotSet';
      const String potSetIncomeFromUI = '25000';
      const double potSetIncomeValideParsed = 25000;
      final PotSet testPotSet = PotSet(
        id: 'id1',
        income: potSetIncomeValideParsed,
        name: potSetNameFromUI,
        createdDate: DateTime.now(),
        pots: [],
      );
      void setUpMockInputConvertterSuccess() {
        when(() => mockInputConverter.stringToUnsignedDouble(any()))
            .thenReturn(const Right(potSetIncomeValideParsed));
      }

      test(
        "should call the InputConverter to validate and convert the string to an insigned double ",
        () async {
          // arrange
          setUpMockInputConvertterSuccess();
          when(() => mockCreatePotSetUseCase(any(), any()))
              .thenAnswer((invocation) => Future(() {}));
          // act
          bloc.add(const CreatePotSetEvent(
            name: potSetNameFromUI,
            income: potSetIncomeFromUI,
          ));
          // assert
          await Future.delayed(const Duration(milliseconds: 1));
          verify(() =>
              mockInputConverter.stringToUnsignedDouble(potSetIncomeFromUI));
        },
      );
    },
  );
}
