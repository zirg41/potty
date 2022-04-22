import 'package:potty/features/potties_manager/domain/entities/pot.dart';

final mockedPotsFull = [
  Pot(id: '1', name: 'name1', percent: 10, amount: 100, isAmountFixed: false),
  Pot(id: '2', name: 'name2', percent: 20, amount: 200, isAmountFixed: false),
  Pot(id: '3', name: 'name3', percent: 40, amount: 400, isAmountFixed: false),
];

final mockedPotsOnlyPercents = [
  Pot(id: '1', name: 'name1', percent: 10, isAmountFixed: false),
  Pot(id: '2', name: 'name2', percent: 20, isAmountFixed: false),
  Pot(id: '3', name: 'name3', percent: 40, isAmountFixed: false),
];

final mockedPotsOnlyAmounts = [
  Pot(id: '1', name: 'name1', amount: 100, isAmountFixed: true),
  Pot(id: '2', name: 'name2', amount: 200, isAmountFixed: true),
  Pot(id: '3', name: 'name3', amount: 400, isAmountFixed: true),
];
final mockedPotsMixedCreatedByPercentsAndAmounts = [
  Pot(id: '1', name: 'name1', amount: 100, isAmountFixed: true),
  Pot(id: '2', name: 'name2', percent: 20, isAmountFixed: false),
  Pot(id: '3', name: 'name3', amount: 400, isAmountFixed: true),
];
