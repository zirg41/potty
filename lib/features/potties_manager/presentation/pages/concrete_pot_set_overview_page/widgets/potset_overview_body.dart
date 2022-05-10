import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../bloc/pots_watcher/pots_watcher_bloc.dart';

class ConcretePotSetBodyWidget extends StatelessWidget {
  final String potSetId;

  const ConcretePotSetBodyWidget({
    required this.potSetId,
    Key? key,
  }) : super(key: key);

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
