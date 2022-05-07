import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';
import 'package:potty/features/potties_manager/domain/usecases/listen_potsets_stream_usecase.dart';
part 'pots_watcher_event.dart';
part 'pots_watcher_state.dart';

class PotsWatcherBloc extends Bloc<PotsWatcherEvent, PotsWatcherState> {
  ListenPotSetsStreamUseCase listenPotSetsStreamUseCase;

  PotsWatcherBloc(this.listenPotSetsStreamUseCase)
      : super(PotsWatcherInitial()) {
    on<PotsWatcherGetAllPotsEvent>((event, emit) {
      emit(const PotsWatcherLoadingState());

      final potsStream = listenPotSetsStreamUseCase();

      potsStream.listen((event) {
        event.fold(
          (failure) async => emit(const PotsWatcherLoadingError()),
          (potSets) async {
            print('got potsstream in bloc ${potSets.length}');

            emit(PotsWatcherLoadedState(potSets));
          },
        );
      });
    });
  }
}
