part of 'pots_watcher_bloc.dart';

abstract class PotsWatcherEvent extends Equatable {
  const PotsWatcherEvent();

  @override
  List<Object> get props => [];
}

class PotsWatcherGetAllPotsEvent extends PotsWatcherEvent {
  const PotsWatcherGetAllPotsEvent();
}

class PotSetsReceivedEvent extends PotsWatcherEvent {
  final Either<Failure, List<PotSet>> failureOrPots;

  const PotSetsReceivedEvent(this.failureOrPots);
  @override
  List<Object> get props => [failureOrPots];
}
