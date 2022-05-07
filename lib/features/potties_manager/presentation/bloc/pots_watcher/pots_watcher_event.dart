part of 'pots_watcher_bloc.dart';

abstract class PotsWatcherEvent extends Equatable {
  const PotsWatcherEvent();

  @override
  List<Object> get props => [];
}

class PotsWatcherGetAllPotsEvent extends PotsWatcherEvent {
  const PotsWatcherGetAllPotsEvent();
}
