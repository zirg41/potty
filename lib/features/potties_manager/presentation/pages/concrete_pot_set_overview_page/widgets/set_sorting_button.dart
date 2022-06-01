import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/features/potties_manager/domain/entities/sorting_logic.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_actor/pots_bloc.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_watcher/pots_watcher_bloc.dart';

class SetPotSetSortingButton extends StatelessWidget {
  final String potSetId;
  final SortingLogic sortingLogic;

  const SetPotSetSortingButton({
    Key? key,
    required this.potSetId,
    required this.sortingLogic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentValue =
        sortingWaysStringList[sortingLogic == SortingLogic.lowToHigh ? 0 : 1];

    return BlocBuilder<PotsWatcherBloc, PotsWatcherState>(
      bloc: BlocProvider.of<PotsWatcherBloc>(context),
      builder: (context, state) {
        if (state is PotSetsLoadedState) {
          return Row(
            children: [
              const Spacer(),
              DropdownButton<String>(
                items: sortingWaysStringList
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                underline: const SizedBox.shrink(),
                isExpanded: false,
                isDense: false,
                value: sortingWaysStringList[
                    sortingLogic == SortingLogic.lowToHigh ? 0 : 1],
                onChanged: (value) {
                  BlocProvider.of<PotsBloc>(context).add(SetSortingEvent(
                      potSetId: potSetId,
                      sortingLogic: value == sortingWaysStringList[0]
                          ? SortingLogic.lowToHigh
                          : SortingLogic.highToLow));
                },
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

const sortingWaysStringList = ['По возрастанию', 'По убыванию'];
