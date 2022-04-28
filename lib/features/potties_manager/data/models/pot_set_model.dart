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
      sortingLogic: _convertFromEntity(potSet.sortingLogic),
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
      sortingLogic: _convertToEntity(sortingLogic),
      pots: pots.map((potSet) => potSet.toPotEntity()).toList(),
      unallocatedBalance: unallocatedBalance,
      unallocatedPercent: unallocatedPercent,
    );
  }

  static SortingLogic _convertToEntity(SortingLogicModel slModel) {
    if (slModel == SortingLogicModel.highToLow) return SortingLogic.highToLow;
    if (slModel == SortingLogicModel.lowToHigh) return SortingLogic.lowToHigh;
    if (slModel == SortingLogicModel.manual) return SortingLogic.manual;
    return SortingLogic.manual;
  }

  static SortingLogicModel _convertFromEntity(SortingLogic slEntity) {
    if (slEntity == SortingLogic.highToLow) return SortingLogicModel.highToLow;
    if (slEntity == SortingLogic.lowToHigh) return SortingLogicModel.lowToHigh;
    if (slEntity == SortingLogic.manual) return SortingLogicModel.manual;
    return SortingLogicModel.manual;
  }
}
