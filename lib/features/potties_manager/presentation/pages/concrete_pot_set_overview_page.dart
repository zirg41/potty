import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/core/errors/failure.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_actor/pots_bloc.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_watcher/pots_watcher_bloc.dart';

class ConcretePotSetOverviewPage extends StatelessWidget {
  final String potSetId;

  const ConcretePotSetOverviewPage({
    required this.potSetId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App bar'),
      ),
      body: ConcretePotSetBodyWidget(potSetId: potSetId),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          BlocProvider.of<PotsBloc>(context).add(
            CreatePotEvent(
                potSetId: potSetId,
                isAmountFixed: false,
                percent: '15',
                name: 'test pot'),
          );
        },
      ),
    );
  }
}

class ConcretePotSetBodyWidget extends StatelessWidget {
  const ConcretePotSetBodyWidget({
    Key? key,
    required this.potSetId,
  }) : super(key: key);

  final String potSetId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PotsWatcherBloc, PotsWatcherState>(
      bloc: BlocProvider.of<PotsWatcherBloc>(context),
      builder: (context, state) {
        if (state is PotsWatcherLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PotsWatcherLoadingError) {
          return const Center(child: Text(GETTING_DATA_FROM_MEMORY_FAILED));
        }
        if (state is PotsWatcherLoadedState) {
          final potSet =
              state.pots.firstWhere((element) => element.id == potSetId);
          return Center(
            child: Text(potSet.toString()),
          );
        }
        return const Center(child: Text(NO_STATE_ERROR));
      },
    );
  }
}
