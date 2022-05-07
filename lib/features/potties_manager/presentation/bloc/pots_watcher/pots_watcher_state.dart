part of 'pots_watcher_bloc.dart';

abstract class PotsWatcherState extends Equatable {
  const PotsWatcherState();

  @override
  List<Object> get props => [];
}

class PotsWatcherInitial extends PotsWatcherState {}

class PotsWatcherLoadingState extends PotsWatcherState {
  const PotsWatcherLoadingState();
}

class PotsWatcherLoadedState extends PotsWatcherState {
  final List<PotSet> pots;

  const PotsWatcherLoadedState(this.pots);
}

class PotsWatcherLoadingError extends PotsWatcherState {
  const PotsWatcherLoadingError();
}
