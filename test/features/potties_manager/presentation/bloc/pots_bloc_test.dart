import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:potty/core/util/input_converter.dart';
import 'package:potty/features/potties_manager/domain/entities/pot.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';
import 'package:potty/features/potties_manager/domain/usecases/create_pot_set_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/create_pot_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/delete_pot_set_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/delete_pot_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/edit_pot_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/edit_potset_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/listen_potsets_stream_usecase.dart';
import 'package:potty/features/potties_manager/domain/usecases/set_sorting_usecase.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_actor/pots_bloc.dart';

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
        setSortingUseCase: mockSetSortingUseCase,
        inputConverter: mockInputConverter);
  });

  group(
    'on CreatePotSetEvent',
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
      void setUpMockInputConverterSuccess() {
        when(() => mockInputConverter.stringToUnsignedDouble(any()))
            .thenReturn(const Right(potSetIncomeValideParsed));
      }

      test(
        "should call the InputConverter to validate and convert the string to an insigned double ",
        () async {
          // arrange
          setUpMockInputConverterSuccess();
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
      test(
        "should call the CreatePotSetUseCase with proper arguments",
        () async {
          // arrange
          setUpMockInputConverterSuccess();
          when(() => mockCreatePotSetUseCase(any(), any()))
              .thenAnswer((_) => Future(() {}));
          // act
          bloc.add(const CreatePotSetEvent(
            name: potSetNameFromUI,
            income: potSetIncomeFromUI,
          ));
          // assert
          await Future.delayed(const Duration(milliseconds: 1));
          verify(() => mockCreatePotSetUseCase(
              potSetNameFromUI, potSetIncomeValideParsed));
        },
      );

      test(
        "should emit [InputErrorState] if input values is not valid",
        () async {
          // arrange
          when(() => mockInputConverter.stringToUnsignedDouble(any()))
              .thenReturn(Left(InvalidInputFailure()));

          // assert later
          final expected = <PotsState>[
            const InputErrorState(message: INVALID_INPUT_FAILURE_MESSAGE),
          ];

          expectLater(bloc.stream, emitsInOrder(expected));

          // act
          bloc.add(const CreatePotSetEvent(
            name: potSetNameFromUI,
            income: potSetIncomeFromUI,
          ));
        },
      );
    },
  );
  group(
    'on CreatePotEvent',
    () {
      const String testPotName = 'test pot';
      const String testPotSetId = 'potSetId';
      const String inputAmountFromUI = '1000';
      const String inputPercentFromUI = '10';
      const double inputAmountParsed = 1000;
      const double inputPercentParsed = 10;
      Pot testPot = Pot(
          id: 'id',
          name: testPotName,
          amount: inputAmountParsed,
          percent: inputPercentParsed);
      void setUpMockInputConverterSuccess(parsedValue) {
        when(() => mockInputConverter.stringToUnsignedDouble(any()))
            .thenReturn(Right(parsedValue));
      }

      test(
        "should call InputConverter to validate and convert the string to double",
        () async {
          // arrange
          setUpMockInputConverterSuccess(inputAmountParsed);
          when(() => mockCreatePotUseCase.call(
              potSetId: testPotSetId,
              name: testPotName,
              amount: inputAmountParsed,
              isAmountFixed: true)).thenAnswer((invocation) => Future(() {}));

          // act
          bloc.add(const CreatePotEvent(
              potSetId: testPotSetId,
              name: testPotName,
              amount: inputAmountFromUI,
              isAmountFixed: true));

          // assert
          await Future.delayed(const Duration(milliseconds: 1));
          verify(() =>
              mockInputConverter.stringToUnsignedDouble(inputAmountFromUI));
        },
      );
    },
  );
}
