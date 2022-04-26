import 'package:potty/features/potties_manager/domain/entities/pot.dart';

abstract class ISortPot {
  List<Pot> sortPots(List<Pot> potsToSort);
}
