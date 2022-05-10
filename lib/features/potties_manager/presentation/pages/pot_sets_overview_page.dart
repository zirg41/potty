import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/features/potties_manager/presentation/routes/router.gr.dart';
import '../../../../dependency_injection.dart';
import '../bloc/pots_actor/pots_bloc.dart';
import '../bloc/pots_watcher/pots_watcher_bloc.dart';
import '../widgets/pots_sets_overview_body.dart';

class PotSetsOverviewPage extends StatelessWidget {
  static const routeName = "/pot-sets-page";
  const PotSetsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('your test pots'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO implement button click handler
          sl<PotsBloc>().add(CreatePotSetEvent(
              name: 'Test Name', income: Random().nextInt(10000).toString()));
        },
      ),
    );
  }
}
