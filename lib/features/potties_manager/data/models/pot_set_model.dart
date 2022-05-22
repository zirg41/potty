import 'package:hive/hive.dart';

import '../../domain/entities/pot_set.dart';
import '../../domain/entities/sorting_logic.dart';
import 'pot_model.dart';
import 'sorting_logic_model.dart';

part 'pot_set_model.g.dart';

@HiveType(typeId: 3)
class PotSetHiveModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late double income;
  @HiveField(3)
  late DateTime createdDate;
  @HiveField(4)
  late List<PotHiveModel> pots;
  @HiveField(5)
  late double? unallocatedBalance;
  @HiveField(6)
  late double? unallocatedPercent;
  @HiveField(7)
  late SortingLogicModel sortingLogic;

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
