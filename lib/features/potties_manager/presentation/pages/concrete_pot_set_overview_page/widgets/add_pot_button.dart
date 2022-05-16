import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/features/potties_manager/presentation/pages/edit_pot_page/edit_pot_widget.dart';
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
      // TODO try delete asyncs
      onTap: () async {
        await showDialog(
          context: context,
          builder: (ctx) {
            return EditPotWidget(
              potSetId: potSetId,
            );
          },
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
