import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:potty/features/potties_manager/domain/repositories/i_pots_repository.dart';
import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/pot_set.dart';
part 'pots_watcher_event.dart';
part 'pots_watcher_state.dart';

class PotsWatcherBloc extends Bloc<PotsWatcherEvent, PotsWatcherState> {
  final IPotsRepository potsRepository;

  StreamSubscription<Either<Failure, List<PotSet>>>? _noteStreamSubscription;

  PotsWatcherBloc({required this.potsRepository})
      : super(PotsWatcherInitial()) {
    on<PotsWatcherGetAllPotsEvent>((event, emit) async {
      emit(const PotsWatcherLoadingState());

      final potsStream = potsRepository.getPotsStream();

      _noteStreamSubscription = potsStream.listen((failureOrPots) {
        add(PotSetsReceived(failureOrPots));
      });
    });

    on<PotSetsReceived>(
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
    _noteStreamSubscription?.cancel();
    return super.close();
  }
}
