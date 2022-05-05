import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:potty/core/errors/failure.dart';
import 'package:potty/core/util/input_converter.dart';
import 'package:potty/core/util/pot_creator.dart';
import 'package:potty/core/util/pots_creator.dart';
import 'package:potty/features/potties_manager/domain/entities/sorting_logic.dart';

import '../../domain/entities/pot_set.dart';
import '../../domain/usecases/create_pot_set_usecase.dart';
import '../../domain/usecases/create_pot_usecase.dart';
import '../../domain/usecases/delete_pot_set_usecase.dart';
import '../../domain/usecases/delete_pot_usecase.dart';
import '../../domain/usecases/edit_pot_usecase.dart';
import '../../domain/usecases/edit_potset_usecase.dart';
import '../../domain/usecases/listen_potsets_stream_usecase.dart';
import '../../domain/usecases/set_sorting_usecase.dart';

part 'pots_event.dart';
part 'pots_state.dart';

class PotsBloc extends Bloc<PotsEvent, PotsState> {
  final CreatePotUseCase createPotUseCase;
  final EditPotUseCase editPotUseCase;
  final DeletePotUseCase deletePotUseCase;
  final CreatePotSetUseCase createPotSetUseCase;
  final EditPotSetUseCase editPotSetUseCase;
  final DeletePotSetUseCase deletePotSetUseCase;
  final ListenPotSetsStreamUseCase listenPotSetsStreamUseCase;
  final SetSortingUseCase setSortingUseCase;
  final InputConverter inputConverter;

  PotsBloc({
    required this.createPotUseCase,
    required this.createPotSetUseCase,
    required this.deletePotSetUseCase,
    required this.deletePotUseCase,
    required this.editPotUseCase,
    required this.editPotSetUseCase,
    required this.listenPotSetsStreamUseCase,
    required this.setSortingUseCase,
    required this.inputConverter,
  }) : super(PotsInitial()) {
    on<GetPotsEvent>((event, emit) {
      emit(LoadingState());
      final potsStream = listenPotSetsStreamUseCase();
      potsStream.listen((event) {
        event.fold(
          (failure) => const GetPotsErrorState(),
          (potSets) => PotSetsLoaded(potSets),
        );
      });
    });

    on<CreatePotSetEvent>(
      (event, emit) {
        final Either<Failure, double> inputEither =
            inputConverter.stringToUnsignedDouble(event.income);

        inputEither.fold(
          (failure) async {
            emit(const InputErrorState(message: INVALID_INPUT_FAILURE_MESSAGE));
          },
          (parsedAmount) async {
            await createPotSetUseCase.call(event.name, parsedAmount);
          },
        );
      },
    );

    on<CreatePotEvent>(
      (event, emit) async {
        // check if user entered a pot with fixed amount
        if (event.isAmountFixed!) {
          final Either<Failure, double> inputEither =
              inputConverter.stringToUnsignedDouble(event.amount!);

          inputEither.fold(
            (failure) async {
              emit(
                const InputErrorState(message: INVALID_INPUT_FAILURE_MESSAGE),
              );
            },
            (parsedAmount) async {
              await createPotUseCase.call(
                potSetId: event.potSetId,
                name: event.name!,
                amount: parsedAmount,
                isAmountFixed: event.isAmountFixed!,
              );
            },
          );
        }
        // check if user entered a pot with fixed percent
        else if (!event.isAmountFixed!) {
          final Either<Failure, double> inputEither =
              inputConverter.stringToUnsignedDouble(event.percent!);

          inputEither.fold(
            (failure) async {
              emit(
                const InputErrorState(message: INVALID_INPUT_FAILURE_MESSAGE),
              );
            },
            (parsedPercent) async {
              await createPotUseCase.call(
                potSetId: event.potSetId,
                name: event.name!,
                percent: parsedPercent,
                isAmountFixed: event.isAmountFixed!,
              );
            },
          );
        }
        // check if user chose a template pot
        else if (event.potCreator != null) {
          await createPotUseCase.call(
            potSetId: event.potSetId,
            potCreator: event.potCreator,
          );
        }
        // program hardly gets to this place, but so
        else {
          emit(
            const InputErrorState(message: INVALID_INPUT_FAILURE_MESSAGE),
          );
        }
      },
    );

    on<DeletePotSetEvent>(
      (event, emit) async {
        await deletePotSetUseCase(potSetIdToDelete: event.potSetIdToDelete);
      },
    );

    on<DeletePotEvent>(
      (event, emit) async {
        await deletePotUseCase.call(
            potSetId: event.potSetId, potIdToDelete: event.potIdToDelete);
      },
    );

    on<EditPotEvent>(
      (event, emit) async {
        // check if user entered a pot with fixed amount
        if (event.isAmountFixed!) {
          final Either<Failure, double> inputEither =
              inputConverter.stringToUnsignedDouble(event.amount!);

          inputEither.fold(
            (failure) async {
              emit(
                const InputErrorState(message: INVALID_INPUT_FAILURE_MESSAGE),
              );
            },
            (parsedAmount) async {
              await editPotUseCase.call(
                potId: event.potId,
                potSetId: event.potSetId,
                name: event.name!,
                amount: parsedAmount,
                isAmountFixed: event.isAmountFixed!,
              );
            },
          );
        }
        // check if user entered a pot with fixed percent
        else if (!event.isAmountFixed!) {
          final Either<Failure, double> inputEither =
              inputConverter.stringToUnsignedDouble(event.percent!);

          inputEither.fold(
            (failure) async {
              emit(
                const InputErrorState(message: INVALID_INPUT_FAILURE_MESSAGE),
              );
            },
            (parsedPercent) async {
              await editPotUseCase.call(
                potId: event.potId,
                potSetId: event.potSetId,
                name: event.name!,
                amount: parsedPercent,
                isAmountFixed: event.isAmountFixed!,
              );
            },
          );
        }
        // check if user chose a template pot
        else if (event.potCreator != null) {
          await editPotUseCase.call(
            potId: event.potId,
            potSetId: event.potSetId,
            potCreator: event.potCreator,
          );
        }
        // program hardly gets to this place, but so
        else {
          emit(
            const InputErrorState(message: INVALID_INPUT_FAILURE_MESSAGE),
          );
        }
      },
    );

    on<EditPotSetNameEvent>(
      (event, emit) {},
    );

    on<EditPotSetIncomeEvent>(
      (event, emit) {},
    );

    on<SetSortingEvent>(
      (event, emit) {},
    );
  }
}
