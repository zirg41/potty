// ignore: must_be_immutable
import 'package:equatable/equatable.dart';

/// WARNING amount fields must be decimal formatted
class Pot extends Equatable {
  late String id;
  late String name;
  double? percent;
  double? amount;
  bool? isAmountFixed;

  Pot({
    required this.id,
    required this.name,
    this.percent,
    this.amount,
    this.isAmountFixed,
  });

  @override
  List<Object?> get props => [id, name, percent, amount, isAmountFixed];

  @override
  String toString() {
    return """\n*Pot*
      Name: $name
      ID: $id
      Percent: $percent%
      Amount: $amount rubles
      IsAmountFixed: $isAmountFixed
      """;
  }
}
