part of 'pots_bloc.dart';

abstract class PotsState extends Equatable {
  const PotsState();

  @override
  List<Object> get props => [];
}

class PotsInitial extends PotsState {}

class LoadingState extends PotsState {}

class PotSetsLoaded extends PotsState {
  final List<PotSet> pots;

  const PotSetsLoaded(this.pots);
}

class GetPotsErrorState extends PotsState {
  const GetPotsErrorState();
}

class InputErrorState extends PotsState {
  final String message;

  const InputErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
