import 'package:flutter/material.dart';

enum DropValue { percent, amount }

const Map<DropValue, Icon> dropdownIconValues = {
  DropValue.percent: Icon(Icons.percent),
  DropValue.amount: Icon(Icons.currency_ruble)
};
