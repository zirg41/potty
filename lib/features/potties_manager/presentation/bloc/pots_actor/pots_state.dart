part of 'pots_bloc.dart';

abstract class PotsState extends Equatable {
  const PotsState();

  @override
  List<Object> get props => [];
}

class PotsInitial extends PotsState {}

class InputErrorState extends PotsState {
  final String message;

  const InputErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
