import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'old_pot_model.g.dart';

@HiveType(typeId: 0)
class OldPot extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  double? percent;

  @HiveField(3)
  double? amount;

  @HiveField(4)
  bool? isAmountFixed;

  OldPot({
    @required this.id,
    @required this.name,
    this.percent,
    this.amount,
    this.isAmountFixed = false,
  });

  @override
  String toString() {
    return name!;
  }
}
