import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_watcher/pots_watcher_bloc.dart';
import 'package:potty/features/potties_manager/presentation/widgets/pot_set_item.dart';

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
          return const Center(child: Text('Getting data from memory failed'));
        }
        if (state is PotsWatcherLoadedState) {
          return ListView.builder(
            itemCount: state.pots.length,
            itemBuilder: (context, index) {
              final potSet = state.pots[index];
              return PotSetItem(potset: potSet);
            },
          );
        }
        return const Center(child: Text('No state'));
      },
    );
  }
}
