import 'package:hive/hive.dart';
import 'package:potty/features/potties_manager/domain/entities/pot.dart';

part 'pot_model.g.dart';

@HiveType(typeId: 0)
class PotHiveModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  double? percent;
  @HiveField(3)
  double? amount;
  @HiveField(4)
  bool? isAmountFixed;

  PotHiveModel({
    required this.id,
    required this.name,
    this.percent,
    this.amount,
    this.isAmountFixed,
  });

  factory PotHiveModel.fromPotEntity(Pot pot) {
    return PotHiveModel(
      id: pot.id,
      name: pot.name,
      amount: pot.amount,
      percent: pot.percent,
      isAmountFixed: pot.isAmountFixed,
    );
  }

  Pot toPotEntity() {
    return Pot(
      id: id,
      name: name,
      amount: amount,
      percent: percent,
      isAmountFixed: isAmountFixed,
    );
  }
}
