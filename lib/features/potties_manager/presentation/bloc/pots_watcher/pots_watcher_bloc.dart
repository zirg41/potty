import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';
part 'pots_watcher_event.dart';
part 'pots_watcher_state.dart';

class PotsWatcherBloc extends Bloc<PotsWatcherEvent, PotsWatcherState> {
  PotsWatcherBloc() : super(PotsWatcherInitial()) {
    on<PotsWatcherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
