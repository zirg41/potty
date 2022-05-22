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
  final _potSetNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final contextTheme = Theme.of(context);

    return BlocListener<PotsBloc, PotsState>(
      listener: (context, state) {
        if (state is PotsChangedSuccesfullyState) {
          setState(() {
            isEditing = false;
          });
        }
      },
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<PotsBloc>(context)
              .add(const UserEditingEitherNameOrIncomeOfPotSetEvent());
          setState(() {
            isEditing = true;
          });
          _potSetNameController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _potSetNameController.text.length,
          );
        },
        child: isEditing
            ? TextField(
                controller: _potSetNameController,
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
                    final potSet =
                        state.getPotSetById(potSetId: widget.potSetId);
                    _potSetNameController.text = potSet.name;
                    return Text(potSet.name);
                  }
                  return const Text(NO_STATE_ERROR);
                },
              ),
      ),
    );
  }
}
