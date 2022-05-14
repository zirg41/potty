import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/features/potties_manager/presentation/pages/pot_sets_overview_page/widgets/pot_set_item.dart';

import '../../../bloc/pots_actor/pots_bloc.dart';

class AddPotButton extends StatelessWidget {
  final String potSetId;

  const AddPotButton({
    required this.potSetId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contextTheme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PotsBloc>(context).add(
          CreatePotEvent(
              potSetId: potSetId,
              isAmountFixed: false,
              percent: '15',
              name: 'test pot'),
        );
      },
      child: Padding(
        padding: itemsPadding,
        child: Card(
          color: contextTheme.colorScheme.surface,
          child: const SizedBox(
            height: 50,
            child: Center(
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
