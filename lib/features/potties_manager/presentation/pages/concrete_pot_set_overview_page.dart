import 'package:flutter/material.dart';

import '../../domain/entities/pot_set.dart';

class ConretePotSetOverviewPage extends StatelessWidget {
  final PotSet potSet;

  const ConretePotSetOverviewPage({
    required this.potSet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App bar'),
      ),
      body: Center(
        child: Text(potSet.toString()),
      ),
    );
  }
}
