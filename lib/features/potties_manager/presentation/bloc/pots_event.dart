part of 'pots_bloc.dart';

abstract class PotsEvent extends Equatable {
  const PotsEvent();

  @override
  List<Object> get props => [];
}

class GetPotsEvent extends PotsEvent {}

class CreatePotSetEvent extends PotsEvent {
  final String name;
  final String income;
  final IPotsCreator? potsCreator;

  const CreatePotSetEvent({
    required this.name,
    required this.income,
    this.potsCreator,
  });

  @override
  List<Object> get props => [name, income];
}

class CreatePotEvent extends PotsEvent {
  final String potSetId;
  final String? name;
  final bool? isAmountFixed;
  final String? amount;
  final String? percent;
  final IPotCreator? potCreator;

  const CreatePotEvent({
    required this.potSetId,
    this.name,
    this.amount,
    this.percent,
    this.isAmountFixed,
    this.potCreator,
  });

  @override
  List<Object> get props =>
      [potSetId, name!, isAmountFixed!, amount!, percent!, potCreator!];
}
