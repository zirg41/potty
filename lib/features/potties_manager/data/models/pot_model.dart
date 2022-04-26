import 'package:potty/features/potties_manager/domain/entities/pot.dart';

class PotHiveModel {
  late String id;
  late String name;
  double? percent;
  double? amount;
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
