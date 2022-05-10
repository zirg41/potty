import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/core/errors/failure.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_watcher/pots_watcher_bloc.dart';

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
        if (state is PotSetsLoadedState) {
          final potSet = state.getPotSetById(potSetId: potSetId);
          return Center(
            child: Text(potSet.toString()),
          );
        }
        return const Center(child: Text(NO_STATE_ERROR));
      },
    );
  }
}
