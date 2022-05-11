import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../bloc/pots_actor/pots_bloc.dart';
import '../../../bloc/pots_watcher/pots_watcher_bloc.dart';

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
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final contextTheme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          isEditing = true;
        });
        controller.selection =
            TextSelection(baseOffset: 0, extentOffset: controller.text.length);
      },
      child: isEditing
          ? TextField(
              controller: controller,
              onSubmitted: (value) {
                BlocProvider.of<PotsBloc>(context).add(EditPotSetNameEvent(
                    potSetId: widget.potSetId, name: value));
                isEditing = false;
              },
              autofocus: true,
              style: contextTheme.textTheme.titleLarge,
              decoration: const InputDecoration(border: InputBorder.none),
            )
          : BlocBuilder<PotsWatcherBloc, PotsWatcherState>(
              bloc: BlocProvider.of<PotsWatcherBloc>(context),
              builder: (context, state) {
                if (state is PotSetsLoadedState) {
                  final potSet = state.getPotSetById(potSetId: widget.potSetId);
                  controller.text = potSet.name;
                  return Text(potSet.name);
                }
                return const Text(NO_STATE_ERROR);
              },
            ),
    );
  }
}
