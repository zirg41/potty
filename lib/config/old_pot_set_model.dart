import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'old_pot_model.dart';

part 'old_pot_set_model.g.dart';

@HiveType(typeId: 1)
class OldPotSet extends HiveObject with ChangeNotifier {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  double? income;

  @HiveField(2)
  String? name;

  @HiveField(3)
  List<OldPot>? pots;

  @HiveField(4)
  double? unallocatedAmount = 0;

  @HiveField(5)
  double? unallocatedPercent = 0;

  OldPotSet({
    this.id,
    this.income,
    this.name,
    this.pots,
  });
}
