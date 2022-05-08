import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/dependency_injection.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_actor/pots_bloc.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_watcher/pots_watcher_bloc.dart';
import 'package:potty/features/potties_manager/presentation/widgets/pots_sets_overview_body.dart';

class PotSetsPage extends StatelessWidget {
  static const routeName = "/pot-sets-page";
  const PotSetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<PotsWatcherBloc>()..add(const PotsWatcherGetAllPotsEvent()),
        ),
        BlocProvider(
          create: (context) => sl<PotsBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('your test pots'),
        ),
        body: const PotSetsOverviewBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO implement button click handler
            sl<PotsBloc>().add(CreatePotSetEvent(
                name: 'name3', income: Random().nextInt(10000).toString()));
          },
        ),
      ),
    );
  }
}
