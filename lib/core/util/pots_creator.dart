import 'package:potty/features/potties_manager/domain/entities/pot.dart';

abstract class IPotsCreator {
  List<Pot> call();
}

class EmptyPotsCreator implements IPotsCreator {
  const EmptyPotsCreator();
  @override
  List<Pot> call() {
    return [];
  }
}
