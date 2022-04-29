import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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

  PotsBloc({
    required this.createPotUseCase,
    required this.createPotSetUseCase,
    required this.deletePotSetUseCase,
    required this.deletePotUseCase,
    required this.editPotUseCase,
    required this.editPotSetUseCase,
    required this.listenPotSetsStreamUseCase,
    required this.setSortingUseCase,
  }) : super(PotsInitial()) {
    on<PotsEvent>((event, emit) {});

    on<GetPotsEvent>((event, emit) {
      emit(LoadingState());
      final potsStream = listenPotSetsStreamUseCase();
      potsStream.listen((event) {
        event.fold(
          (failure) => GetPotsErrorState(),
          (potSets) => PotSetsLoaded(potSets),
        );
      });
    });

    on<CreatePotSetEvent>(
      (event, emit) {},
    );

    on<CreatePotEvent>(
      (event, emit) {},
    );

    on<DeletePotSetEvent>(
      (event, emit) {},
    );

    on<DeletePotEvent>(
      (event, emit) {},
    );

    on<EditPotEvent>(
      (event, emit) {},
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
