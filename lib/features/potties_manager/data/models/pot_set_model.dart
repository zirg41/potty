import 'package:potty/features/potties_manager/data/models/pot_model.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';
import 'package:potty/features/potties_manager/domain/usecases/sort_pot.dart';

class PotSetHiveModel {
  late String id;
  late String name;
  late double income;
  late DateTime createdDate;
  late List<PotHiveModel> pots;
  late double? unallocatedBalance;
  late double? unallocatedPercent;
  late ISortPot sortingLogic;

  PotSetHiveModel({
    required this.id,
    required this.income,
    required this.name,
    required this.createdDate,
    required this.pots,
    this.unallocatedBalance,
    this.unallocatedPercent,
    required this.sortingLogic,
  });

  factory PotSetHiveModel.fromPotSetEntity(PotSet potSet) {
    return PotSetHiveModel(
      id: potSet.id,
      income: potSet.income,
      name: potSet.name,
      createdDate: potSet.createdDate,
      pots: potSet.pots.map((pot) => PotHiveModel.fromPotEntity(pot)).toList(),
      sortingLogic: potSet.sortingLogic,
      unallocatedBalance: potSet.unallocatedBalance,
      unallocatedPercent: potSet.unallocatedPercent,
    );
  }

  PotSet toPotSetEntity() {
    return PotSet(
      id: id,
      income: income,
      name: name,
      createdDate: createdDate,
      sortingLogic: sortingLogic,
      pots: pots.map((potSet) => potSet.toPotEntity()).toList(),
      unallocatedBalance: unallocatedBalance,
      unallocatedPercent: unallocatedPercent,
    );
  }
}
