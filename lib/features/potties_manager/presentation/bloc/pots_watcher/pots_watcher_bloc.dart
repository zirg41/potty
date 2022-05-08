import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:potty/core/errors/failure.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';
import 'package:potty/features/potties_manager/domain/usecases/listen_potsets_stream_usecase.dart';
part 'pots_watcher_event.dart';
part 'pots_watcher_state.dart';

class PotsWatcherBloc extends Bloc<PotsWatcherEvent, PotsWatcherState> {
  final ListenPotSetsStreamUseCase listenPotSetsStreamUseCase;
  StreamSubscription<Either<Failure, List<PotSet>>>? _noteStreamSubscription;

  PotsWatcherBloc(this.listenPotSetsStreamUseCase)
      : super(PotsWatcherInitial()) {
    on<PotsWatcherGetAllPotsEvent>((event, emit) async {
      emit(const PotsWatcherLoadingState());

      final potsStream = listenPotSetsStreamUseCase();

      potsStream.listen((failureOrPots) {
        add(PotsWatcherPotsReceived(failureOrPots));
      });
    });

    on<PotsWatcherPotsReceived>(
      (event, emit) {
        event.failureOrPots.fold(
          (failure) async => emit(const PotsWatcherLoadingError()),
          (potSets) async {
            emit(PotsWatcherLoadedState(potSets));
          },
        );
      },
    );
  }
  @override
  Future<void> close() {
    _noteStreamSubscription?.cancel();
    return super.close();
  }
}
