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

class DeletePotSetEvent extends PotsEvent {
  final String potSetIdToDelete;

  const DeletePotSetEvent({required this.potSetIdToDelete});

  @override
  List<Object> get props => [potSetIdToDelete];
}

class DeletePotEvent extends PotsEvent {
  final String potSetId;
  final String potIdToDelete;

  const DeletePotEvent({
    required this.potSetId,
    required this.potIdToDelete,
  });

  @override
  List<Object> get props => [potSetId, potIdToDelete];
}

class EditPotEvent extends PotsEvent {
  final String potSetId;
  final String potId;
  final String? name;
  final bool? isAmountFixed;
  final double? amount;
  final double? percent;
  final IPotCreator? potCreator;

  const EditPotEvent({
    required this.potSetId,
    required this.potId,
    this.name,
    this.isAmountFixed,
    this.amount,
    this.percent,
    this.potCreator,
  });

  @override
  List<Object> get props => [
        potSetId,
        potId,
        name!,
        isAmountFixed!,
        amount!,
        percent!,
        potCreator!,
      ];
}

class EditPotSetNameEvent extends PotsEvent {
  final String potSetId;
  final String name;

  const EditPotSetNameEvent({
    required this.potSetId,
    required this.name,
  });

  @override
  List<Object> get props => [potSetId, name];
}

class EditPotSetIncomeEvent extends PotsEvent {
  final String potSetId;
  final String income;

  const EditPotSetIncomeEvent({
    required this.potSetId,
    required this.income,
  });

  @override
  List<Object> get props => [potSetId, income];
}
