import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../bloc/pots_actor/pots_bloc.dart';
import '../../../bloc/pots_watcher/pots_watcher_bloc.dart';

class IncomeWidget extends StatefulWidget {
  final String potSetId;

  const IncomeWidget({
    required this.potSetId,
    Key? key,
  }) : super(key: key);

  @override
  State<IncomeWidget> createState() => _IncomeWidgetState();
}

class _IncomeWidgetState extends State<IncomeWidget> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final contextTheme = Theme.of(context);
    return BlocBuilder<PotsWatcherBloc, PotsWatcherState>(
      bloc: BlocProvider.of<PotsWatcherBloc>(context),
      builder: (context, state) {
        if (state is PotSetsLoadedState) {
          final potSet = state.getPotSetById(potSetId: widget.potSetId);

          _controller.text = potSet.income.toString();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FractionallySizedBox(
              widthFactor: 0.4,
              child: TextField(
                textAlign: TextAlign.center,
                onSubmitted: (value) {
                  BlocProvider.of<PotsBloc>(context).add(EditPotSetIncomeEvent(
                      potSetId: widget.potSetId, income: value));
                },
                controller: _controller,
                style: contextTheme.textTheme.titleLarge!.copyWith(height: 1),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.currency_ruble),
                  suffixIconConstraints: BoxConstraints(maxWidth: 20),
                  border: InputBorder.none,
                ),
              ),
            ),
          );
        }
        return const Text(NO_STATE_ERROR);
      },
    );
  }
}
