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

class PotsChangedSuccesfullyState extends PotsState {
  const PotsChangedSuccesfullyState();
}
