import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../bloc/pots_watcher/pots_watcher_bloc.dart';
import 'pot_set_item.dart';

class PotSetsOverviewBody extends StatelessWidget {
  const PotSetsOverviewBody({Key? key}) : super(key: key);

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
        if (state is PotSetsLoadedState) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              itemCount: state.pots.length,
              reverse: false,
              itemBuilder: (context, index) {
                final potSet = state.pots.reversed.toList()[index];
                return PotSetItem(potset: potSet);
              },
            ),
          );
        }
        return const Center(child: Text(NO_STATE_ERROR));
      },
    );
  }
}
