import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/repositories/i_pots_repository.dart';
import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/pot_set.dart';
part 'pots_watcher_event.dart';
part 'pots_watcher_state.dart';

class PotsWatcherBloc extends Bloc<PotsWatcherEvent, PotsWatcherState> {
  final IPotsRepository potsRepository;

  StreamSubscription<Either<Failure, List<PotSet>>>? _potsStreamSubscription;

  PotsWatcherBloc({required this.potsRepository})
      : super(PotsWatcherInitial()) {
    on<PotsWatcherGetAllPotsEvent>((event, emit) async {
      emit(const PotsWatcherLoadingState());

      final potsStream = potsRepository.getPotsStream();

      _potsStreamSubscription = potsStream.listen((failureOrPots) {
        add(PotSetsReceivedEvent(failureOrPots));
      });
    });

    on<PotSetsReceivedEvent>(
      (event, emit) {
        event.failureOrPots.fold(
          (failure) async => emit(const PotsWatcherLoadingError()),
          (potSets) async {
            emit(PotSetsLoadedState(potSets));
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _potsStreamSubscription?.cancel();
    return super.close();
  }
}
