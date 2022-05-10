import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/core/errors/failure.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_watcher/pots_watcher_bloc.dart';

class PotSetAppBar extends StatefulWidget {
  final String potSetId;
  const PotSetAppBar({
    Key? key,
    required this.potSetId,
  }) : super(key: key);

  @override
  State<PotSetAppBar> createState() => _PotSetAppBarState();
}

class _PotSetAppBarState extends State<PotSetAppBar> {
  bool isEditing = false;
  final contoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final contextTheme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          isEditing = true;
        });
      },
      child: isEditing
          ? TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: contextTheme.textTheme.titleLarge,
              controller: contoller,
            )
          : BlocBuilder<PotsWatcherBloc, PotsWatcherState>(
              bloc: BlocProvider.of<PotsWatcherBloc>(context),
              builder: (context, state) {
                if (state is PotsWatcherLoadedState) {
                  final potSet = state.pots
                      .firstWhere((element) => element.id == widget.potSetId);
                  contoller.text = potSet.name;
                  return Text(potSet.name);
                }
                return Text(NO_STATE_ERROR);
              },
            ),
    );
  }
}
