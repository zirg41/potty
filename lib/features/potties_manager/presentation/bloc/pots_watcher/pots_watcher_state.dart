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

class PotSetsLoadedState extends PotsWatcherState {
  final List<PotSet> pots;

  const PotSetsLoadedState(this.pots);
  @override
  List<Object> get props => [pots];

  PotSet getPotSetById({required String potSetId}) {
    return pots.firstWhere((element) => element.id == potSetId);
  }
}

class PotsWatcherLoadingError extends PotsWatcherState {
  const PotsWatcherLoadingError();
}
