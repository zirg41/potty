import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/features/potties_manager/presentation/pages/concrete_pot_set_overview_page/widgets/add_pot_button.dart';
import 'package:potty/features/potties_manager/presentation/pages/concrete_pot_set_overview_page/widgets/income_widget.dart';
import 'package:potty/features/potties_manager/presentation/pages/concrete_pot_set_overview_page/widgets/pot_item.dart';
import 'package:potty/features/potties_manager/presentation/pages/concrete_pot_set_overview_page/widgets/unallocated_pot.dart';
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
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: IncomeWidget(potSetId: potSet.id)),
              if (potSet.unallocatedBalance != 0.0)
                SliverToBoxAdapter(
                  child: UnallocatedPot(
                      percent: potSet.unallocatedPercent!,
                      amount: potSet.unallocatedBalance!,
                      potSetId: potSetId),
                ),
              if (potSet.unallocatedBalance != 0.0)
                const SliverToBoxAdapter(child: Divider()),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return PotItem(potSetId: potSetId, pot: potSet.pots[index]);
                  },
                  childCount: potSet.pots.length,
                ),
              ),
              if (potSet.unallocatedBalance != 0.0)
                SliverToBoxAdapter(child: AddPotButton(potSetId: potSetId)),
            ],
          );
        }
        return const Center(child: Text(NO_STATE_ERROR));
      },
    );
  }
}
