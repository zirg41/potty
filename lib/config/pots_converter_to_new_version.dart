import 'package:hive_flutter/adapters.dart';
import 'old_pot_model.dart';
import 'old_pot_set_model.dart';
import '../core/util/pots_creator.dart';
import '../dependency_injection.dart';
import '../features/potties_manager/domain/entities/pot.dart';
import '../features/potties_manager/presentation/bloc/pots_actor/pots_bloc.dart';

Future<void> convertOldPotSetToNewOne() async {
  late Box<OldPotSet> oldPotSetBox;
  List<OldPotSet> oldPotSetList = [];

  Hive.registerAdapter(OldPotSetAdapter());
  Hive.registerAdapter(OldPotAdapter());

  await Hive.openBox<OldPotSet>("pot_sets");
  oldPotSetBox = Hive.box('pot_sets');

  for (var element in oldPotSetBox.values) {
    oldPotSetList.add(element);
  }

  final potsBloc = sl<PotsBloc>();

  for (var oldPotSet in oldPotSetList) {
    potsBloc.add(
      CreatePotSetEvent(
        name: oldPotSet.name!,
        income: oldPotSet.income.toString(),
        potsCreator: OldPotsCreator(
          oldPotSet.pots!
              .map(
                (oldPot) => Pot(
                  id: oldPot.id!,
                  name: oldPot.name!,
                  isAmountFixed: oldPot.isAmountFixed,
                  amount: oldPot.amount,
                  percent: oldPot.percent,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  for (var element in oldPotSetBox.values) {
    element.delete();
  }
}

class OldPotsCreator implements IPotsCreator {
  final List<Pot> oldPots;
  const OldPotsCreator(this.oldPots);
  @override
  List<Pot> call() {
    return oldPots;
  }
}
