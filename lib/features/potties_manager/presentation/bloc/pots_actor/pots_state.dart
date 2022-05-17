part of 'pots_bloc.dart';

abstract class PotsState extends Equatable {
  const PotsState();

  @override
  List<Object> get props => [];
}

class PotsInitial extends PotsState {}

class IncomeInputErrorState extends PotsState {
  final String message;

  const IncomeInputErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class PercentOrAmountInputErrorState extends PotsState {
  final String message;

  const PercentOrAmountInputErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class PotsChangedSuccesfullyState extends PotsState {
  final String stateId;
  const PotsChangedSuccesfullyState(this.stateId);

  @override
  List<Object> get props => [stateId];
}

class WaitingActionsFromUserState extends PotsState {
  const WaitingActionsFromUserState();
}
