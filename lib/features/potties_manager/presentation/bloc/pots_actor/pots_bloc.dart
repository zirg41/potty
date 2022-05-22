import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/util/input_converter.dart';
import '../../../../../core/util/pot_creator.dart';
import '../../../../../core/util/pots_creator.dart';
import '../../../domain/entities/sorting_logic.dart';
import '../../../domain/usecases/create_pot_set_usecase.dart';
import '../../../domain/usecases/create_pot_usecase.dart';
import '../../../domain/usecases/delete_pot_set_usecase.dart';
import '../../../domain/usecases/delete_pot_usecase.dart';
import '../../../domain/usecases/edit_pot_usecase.dart';
import '../../../domain/usecases/edit_potset_usecase.dart';
import '../../../domain/usecases/set_sorting_usecase.dart';

part 'pots_event.dart';
part 'pots_state.dart';

class PotsBloc extends Bloc<PotsEvent, PotsState> {
  final CreatePotUseCase createPotUseCase;
  final EditPotUseCase editPotUseCase;
  final DeletePotUseCase deletePotUseCase;
  final CreatePotSetUseCase createPotSetUseCase;
  final EditPotSetUseCase editPotSetUseCase;
  final DeletePotSetUseCase deletePotSetUseCase;
  final SetSortingUseCase setSortingUseCase;
  final InputConverter inputConverter;

  PotsBloc({
    required this.createPotUseCase,
    required this.createPotSetUseCase,
    required this.deletePotSetUseCase,
    required this.deletePotUseCase,
    required this.editPotUseCase,
    required this.editPotSetUseCase,
    required this.setSortingUseCase,
    required this.inputConverter,
  }) : super(PotsInitial()) {
    on<CreatePotSetEvent>(
      (event, emit) {
        final Either<Failure, double> inputEither =
            inputConverter.stringToUnsignedDouble(event.income);

        inputEither.fold(
          (failure) async {
            emit(const IncomeInputErrorState(
                message: INVALID_INPUT_FAILURE_MESSAGE));
          },
          (parsedAmount) async {
            await createPotSetUseCase(event.name, parsedAmount,
                potsCreator: event.potsCreator ?? const EmptyPotsCreator());
            add(const PotsChangedSuccesfullyEvent());
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
                const PercentOrAmountInputErrorState(
                    message: INVALID_INPUT_FAILURE_MESSAGE),
              );
            },
            (parsedAmount) async {
              await createPotUseCase.call(
                potSetId: event.potSetId,
                name: event.name!,
                amount: parsedAmount,
                isAmountFixed: event.isAmountFixed!,
              );
              add(const PotsChangedSuccesfullyEvent());
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
                const PercentOrAmountInputErrorState(
                    message: INVALID_INPUT_FAILURE_MESSAGE),
              );
            },
            (parsedPercent) async {
              await createPotUseCase.call(
                potSetId: event.potSetId,
                name: event.name!,
                percent: parsedPercent,
                isAmountFixed: event.isAmountFixed!,
              );
              add(const PotsChangedSuccesfullyEvent());
            },
          );
        }
        // check if user chose a template pot
        else if (event.potCreator != null) {
          await createPotUseCase.call(
            potSetId: event.potSetId,
            potCreator: event.potCreator,
          );
          add(const PotsChangedSuccesfullyEvent());
        }
        // program hardly gets to this place, but so
        else {
          emit(
            const PercentOrAmountInputErrorState(
                message: INVALID_INPUT_FAILURE_MESSAGE),
          );
        }
      },
    );

    on<DeletePotSetEvent>(
      (event, emit) async {
        await deletePotSetUseCase.call(
            potSetIdToDelete: event.potSetIdToDelete);
        add(const PotsChangedSuccesfullyEvent());
      },
    );

    on<DeletePotEvent>(
      (event, emit) async {
        await deletePotUseCase.call(
            potSetId: event.potSetId, potIdToDelete: event.potIdToDelete);
        add(const PotsChangedSuccesfullyEvent());
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
                const PercentOrAmountInputErrorState(
                    message: INVALID_INPUT_FAILURE_MESSAGE),
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
              add(const PotsChangedSuccesfullyEvent());
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
                const PercentOrAmountInputErrorState(
                    message: INVALID_INPUT_FAILURE_MESSAGE),
              );
            },
            (parsedPercent) async {
              await editPotUseCase.call(
                potId: event.potId,
                potSetId: event.potSetId,
                name: event.name!,
                percent: parsedPercent,
                isAmountFixed: event.isAmountFixed!,
              );
              add(const PotsChangedSuccesfullyEvent());
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
          add(const PotsChangedSuccesfullyEvent());
        }
        // program hardly gets to this place, but so
        else {
          emit(
            const PercentOrAmountInputErrorState(
                message: INVALID_INPUT_FAILURE_MESSAGE),
          );
        }
      },
    );

    on<EditPotSetNameEvent>(
      (event, emit) async {
        await editPotSetUseCase.changePotSetName(
            potSetId: event.potSetId, newName: event.name);
        add(const PotsChangedSuccesfullyEvent());
      },
    );

    on<EditPotSetIncomeEvent>(
      (event, emit) async {
        final Either<Failure, double> inputEither =
            inputConverter.stringToUnsignedDouble(event.income);

        inputEither.fold(
          (failure) async {
            emit(
              const IncomeInputErrorState(
                  message: INVALID_INPUT_FAILURE_MESSAGE),
            );
          },
          (parsedIncome) async {
            await editPotSetUseCase.changePotSetIncome(
                potSetId: event.potSetId, newIncome: parsedIncome);
            add(const PotsChangedSuccesfullyEvent());
          },
        );
      },
    );

    on<SetSortingEvent>(
      (event, emit) async {
        await setSortingUseCase.call(
          potSetId: event.potSetId,
          sortingLogic: event.sortingLogic,
        );
        add(const PotsChangedSuccesfullyEvent());
      },
    );

    on<PotsChangedSuccesfullyEvent>(
      (event, emit) {
        emit(PotsChangedSuccesfullyState(Uuid().v1()));
      },
    );

    on<UserIsFixingInputErrorEvent>(
      (event, emit) {
        emit(const WaitingActionsFromUserState());
      },
    );

    on<UserEditingEitherNameOrIncomeOfPotSetEvent>(
      (event, emit) {
        emit(const UserEditingEitherNameOrIncomeOfPotSetState());
      },
    );
  }
}
