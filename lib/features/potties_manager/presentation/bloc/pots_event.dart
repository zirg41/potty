part of 'pots_bloc.dart';

abstract class PotsEvent extends Equatable {
  const PotsEvent();

  @override
  List<Object> get props => [];
}

class GetPotsEvent extends PotsEvent {}
