import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../routes/router.gr.dart';
import '../../bloc/pots_actor/pots_bloc.dart';
import 'widgets/pots_sets_overview_body.dart';

class PotSetsOverviewPage extends StatelessWidget {
  const PotSetsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('potty'),
        actions: [
          IconButton(
            onPressed: () {
              AutoRouter.of(context).pushNamed(const SettingsRoute().path);
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: const PotSetsOverviewBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO implement button click handler
          BlocProvider.of<PotsBloc>(context).add(CreatePotSetEvent(
              name: 'Test Name', income: Random().nextInt(10000).toString()));
        },
        icon: const Icon(Icons.add),
        label: const Text("Создать"),
      ),
    );
  }
}
