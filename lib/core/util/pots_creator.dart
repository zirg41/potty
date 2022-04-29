import 'package:potty/features/potties_manager/domain/entities/pot.dart';

abstract class PotsCreator {
  List<Pot> call();
}

class EmptyPotsCreator implements PotsCreator {
  const EmptyPotsCreator();
  @override
  List<Pot> call() {
    return [];
  }
}
