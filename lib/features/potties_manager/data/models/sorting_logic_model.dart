import 'package:hive/hive.dart';

part 'sorting_logic_model.g.dart';

@HiveType(typeId: 4)
enum SortingLogicModel {
  @HiveField(0)
  lowToHigh,
  @HiveField(1)
  highToLow,
  @HiveField(2)
  manual,
}
