// ignore: must_be_immutable
class Pot {
  late String id;
  late String name;
  final double? percent;
  final double? amount;
  final bool? isAmountFixed;

  Pot({
    required this.id,
    required this.name,
    this.percent,
    this.amount,
    this.isAmountFixed,
  });
}
