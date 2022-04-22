// ignore: must_be_immutable
/// WARNING amount fields must be decimal formatted
class Pot {
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
}
