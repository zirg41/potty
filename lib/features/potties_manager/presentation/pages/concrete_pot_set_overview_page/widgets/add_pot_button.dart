import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/pots_actor/pots_bloc.dart';
import '../../edit_pot_page/edit_pot_widget.dart';
import '../../pot_sets_overview_page/widgets/pot_set_item.dart';

class AddPotButton extends StatelessWidget {
  final String potSetId;

  const AddPotButton({
    required this.potSetId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEnabled = true;

    final contextTheme = Theme.of(context);
    return BlocListener<PotsBloc, PotsState>(
      listener: (context, state) {
        if (state is UserEditingEitherNameOrIncomeOfPotSetState) {
          isEnabled = false;
        }
        if (state is PotsChangedSuccesfullyState) {
          isEnabled = true;
        }
      },
      child: GestureDetector(
        onTap: () {
          if (isEnabled) {
            showDialog(
              context: context,
              builder: (ctx) {
                return EditPotWidget(
                  potSetId: potSetId,
                );
              },
            );
          } else {
            FocusManager.instance.primaryFocus?.unfocus();
            BlocProvider.of<PotsBloc>(context)
                .add(const PotsChangedSuccesfullyEvent());
          }
        },
        child: Padding(
          padding: itemsPadding,
          child: Card(
            elevation: 5,
            color: contextTheme.colorScheme.surface,
            child: const SizedBox(
              height: 50,
              child: Center(
                child: Icon(Icons.add),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
