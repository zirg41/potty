import 'package:potty/features/potties_manager/domain/entities/pot.dart';

abstract class IPotCreator {
  Pot call();
}

class EmptyPot implements IPotCreator {
  const EmptyPot();
  @override
  Pot call() {
    return Pot(
      id: 'id',
      name: "Безымянный",
      percent: 0,
      amount: 0,
      isAmountFixed: false,
    );
  }
}
